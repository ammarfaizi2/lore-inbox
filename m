Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVBURCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVBURCu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 12:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVBURCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 12:02:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15317 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262039AbVBURCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 12:02:48 -0500
Message-ID: <421A142A.1060302@pobox.com>
Date: Mon, 21 Feb 2005 12:02:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: Problem: how to sequence reset of PCI hardware
References: <9e47339105022023242e2fd9ce@mail.gmail.com>	 <42199DD9.10807@pobox.com> <9e47339105022108527e3c679d@mail.gmail.com>
In-Reply-To: <9e47339105022108527e3c679d@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On Mon, 21 Feb 2005 03:37:45 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>You either need to execute the video BIOS to initialize the hardware
>>registers, or initialize the hardware registers themselves.
> 
> 
> That is what the user mode reset program does.
> 
> The problem is, how do I get it to run before calling the device's
> probe function? Most of the framebuffer drivers assume that the
> hardware has already been reset in their probe code.

<shrug>  You do precisely what you just said:  run it before the 
device's probe function.

That typically means either initramfs addition or using 'install 
<module> command...' in /etc/modprobe.conf.

	Jeff


