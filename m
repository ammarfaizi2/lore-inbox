Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbVK3Efp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbVK3Efp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 23:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbVK3Efo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 23:35:44 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:7116 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750911AbVK3Efo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 23:35:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Rk/pRnOWCZzJ8o8O6nfpPw0kIkINGbXDS8hh3Hbc9UJOcWzkXO3BTDPtatCgAiYr3vBWUrh0fF27eE/Xw/1NI4YzcTlD4HPyFxGc+KiFFNOMGLgT2lZ+AmL2LFBNiAbrDnbr8XxHvomDfpGrq/ZFHk5xgz6sqhpK7U+IIFfO1SQ=
Message-ID: <438D2C19.3030008@gmail.com>
Date: Wed, 30 Nov 2005 13:35:37 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "0602@eq.cz" <0602@eq.cz>
CC: linux-kernel@vger.kernel.org, Linux-ide <linux-ide@vger.kernel.org>
Subject: Re: totally random "VFS: Cannot open root device"
References: <438B6E05.8070009@eq.cz>
In-Reply-To: <438B6E05.8070009@eq.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

0602@eq.cz wrote:
> Hi!
> 
> (Please CC me your answers as I am not subscribed.)
> 
> I have a problem with 2.6.14.3 kernel (but this probably isn't too 
> version-specific). I have a kernel which succesfully boots on totally 
> random basis (cca 70% is success). My root partition resides on a SATA 
> disc connected to a controller on Intel 6300ESB ICH southbridge (mb 
> Intel se7320vp2). There is a reiserfs 3 filesystem on my root partition. 
> Without any changes to configuration (os or bios or whatever) I 
> sometimes get:
> 
> VFS: Cannot open root device "801" or unknown block(8,1)
> 
> Could this be some timeout issue, or indication of crappy hw? I've tried 
> this about 10 times (immediately ctrl+alt+del on successfull boot or 
> reset button on aforementioned panic) and I saw no regularities in this 
> misbehaviour.
> 
> I sincerely appreciate any advice anyone can give.
> 

[CC'ing linux-ide]

Hello, 0602.  :-)

Can you please post dmesg of a successful booting?  That will tell us 
which SATA controller/disks you are using.  Also, the boot log of a 
failed boot will be very helpful - the best way to get this is via 
serial console.  If you don't have access to serial console, taking note 
   / picture of the part where SATA detection fails will do too.

Also, when the machine boots successfully, does it work without 
generating disk related kernel logs?  Just perform any IO-heavy 
operations - cp'ing directories which contain large files, 
tar/untarring... - and see if the kernel complains about anyting.

-- 
tejun
