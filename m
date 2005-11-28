Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVK1BCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVK1BCy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 20:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVK1BCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 20:02:54 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:35119 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751209AbVK1BCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 20:02:53 -0500
Date: Sun, 27 Nov 2005 19:01:34 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: What's wrong with this really simple function?
In-reply-to: <5dCs1-7zM-853@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <438A56EE.8030603@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5dCs1-7zM-853@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohamed El Dawy wrote:
> Hi,
>  I have created this 5-liner system call, which basically opens a
> file, write "Hello World" to it, and then returns. That's all.
> 
> Now, when I actually call it, it creates the file successfully but
> writes nothing to it. The file is created and is only zero bytes. So,
> either write didn't write, or close didn't close. Any help would be
> greatly appreciated.

Well, the main thing wrong is that you are writing to a file from inside 
the kernel, that is just wrong.. However likely the reason why the write 
didn't work is that it expects an address inside userspace memory and 
you've given it a character literal which is inside the kernel address 
space.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

