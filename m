Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVCPFZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVCPFZC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 00:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVCPFZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 00:25:02 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:26954 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262522AbVCPFYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 00:24:47 -0500
Date: Tue, 15 Mar 2005 23:24:02 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Taking strlen of buffers copied from userspace
In-reply-to: <3IykC-5x0-29@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4237C2F2.5010203@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3IugU-2m4-11@gated-at.bofh.it> <3IugU-2m4-9@gated-at.bofh.it>
 <3IykC-5x0-29@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> The latter one does (before the listed code):
> 
>     memset(line, 0, LINE_SIZE);
>     if (len > LINE_SIZE)
>         len = LINE_SIZE;
>     if (copy_from_user(line, buf, len - 1))
>         return -EFAULT;
> 
> so isn't line[LINE_SIZE - 1] always 0 ?

In that case, yes (I hadn't looked at the surrounding code). Rather an 
odd way of doing it, but shouldn't have that problem. Could still be 
subject to problems if buf contains a null at the first character, 
unless they're somehow preventing that too..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

