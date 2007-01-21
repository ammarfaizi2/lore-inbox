Return-Path: <linux-kernel-owner+w=401wt.eu-S1751299AbXAUI7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbXAUI7s (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 03:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbXAUI7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 03:59:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:50899 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbXAUI7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 03:59:47 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dUkrY7OIICqs6oQotE5v/qqKgKblvO2aEM+Yt0nLWnAg3UYNrT+WFu/djoAp1g0FlxCVxJRUzabOw3v0O9WqgFArLpS4DPVQxntjMfix7geO/rvwgd63rBqWonrEIeNmSwEEKMOuJeXeJvlVf+TJpS1rkWT2XsBy5vVAJOcOHaY=
Message-ID: <45B32B80.4050208@gmail.com>
Date: Sun, 21 Jan 2007 11:59:44 +0300
From: Ivan Ukhov <uvsoft@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: UVSoft@gmail.com
Subject: Re: How to use an usb interface than is claimed by HID?
References: <45B265E0.5020605@gmail.com> <Pine.LNX.4.64.0701210006591.21127@twin.jikos.cz> <45B2AA03.4070405@gmail.com> <Pine.LNX.4.64.0701210050490.21127@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0701210050490.21127@twin.jikos.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Could I ask you what precisely is the driver you are talking about doing? 
> Why is it not going to be a part of mainline kernel (i.e. being able to be 
> put on blacklist easily).
>   
It's a tiny driver and it hardy can be a part of the mainline kernel 
because of its useless for everyone but me, beside I don't want to make 
someone modify the kernel code. For example, I've written this driver, 
than someone who wanna use it takes the code and tries to deal with it 
and he finds out that he also needs to have the latest kernel (where the 
device is included to that black list) or to fix the kernel himself. 
It's rather uncomfortable for a person who just wants to use a simple 
device with a simple driver, isn't it? It'll be great if my driver can 
manage it himself.
> Sure, there are such in-kernel drivers ... for example Wacom driver. This 
> driver is in-kernel, and it is hooked inside the usb_hid_configure() 
> function to be ignored by the HID layer completely, and all the driver 
> specific handling is handled in drivers/usb/input/wacom*.
>
> (When looking at that code, it looks quite ugly by the way. I have no idea 
> why wacom driver is not using HID_QUIRK_IGNORE, but has a hardcoded hook 
> in the usb_hid_configure() instead. I will probably fix this.)
>   
As far as I remember this driver modifies the HID driver... it's what I 
was talking about late.
