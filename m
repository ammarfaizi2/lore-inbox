Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbVCXBsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVCXBsQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVCXBsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:48:16 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:21815 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262369AbVCXBsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:48:11 -0500
Date: Wed, 23 Mar 2005 19:47:52 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Some questions about VM flags
In-reply-to: <3LnM0-5Wf-27@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42421C48.6010600@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-15
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3LnM0-5Wf-27@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Falavigna wrote:
> Shouldn't printf generate a segfault trying to read a variabile located in a
> write-only area?

What architecture is this on? On many CPUs it is not possible to enforce 
a write-only memory area in most cases (there is no way to give write 
permissions without giving read permissions).

> 
> Shellcode lies in this segment. It is executed even if VM_EXEC isn't set. I
> think execution shouldn't be permitted if only VM_READ or VM_WRITE flags are
> set. Buffer overflows/format string based exploits wouldn't be so popular if we
> implemented this feaure. Please let me know your opinion.

Likewise, many CPUs cannot enforce execution restrictions separate from 
read restrictions (x86 CPUs are like this, except for the latest ones 
with NX support, or if you're using a kernel patch like exec-shield that 
tries to emulate this support).

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

