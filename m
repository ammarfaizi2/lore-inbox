Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbVKMOdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVKMOdg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 09:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVKMOdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 09:33:36 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:59708 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932509AbVKMOdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 09:33:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AVCCpR89AptFyDrSE+jfSxRHpc8XpmA9orWo32OD2CkYw52mXAfUvEyUmHhnjZ7MD0SAnKMdAx1nJ9CJ5DRD9qGCKChtTH2VlzDPd/7gPszY3LKkDSXTQWA6NrG1CyiEu1qKR7RpgCpKJ0aCQG8WlHLxahXp/AgRyCDTBTetNs4=
Message-ID: <43774EAE.90004@gmail.com>
Date: Sun, 13 Nov 2005 22:33:18 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Jason <dravet@hotmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
References: <43766AC5.9080406@gmail.com> <20051113110618.GD4117@implementation>
In-Reply-To: <20051113110618.GD4117@implementation>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault wrote:
> Antonino A. Daplas, le Sun 13 Nov 2005 06:20:53 +0800, a écrit :
>> "I updated to the development kernel and now during boot only the top of the
>> text is visable. For example the monitor screen the is the lines and I can
>> only  see text in the asterik area.
>> ---------------------
>> | ****************  |
>> | *              *  |
>> | *              *  |
>> | ****************  |
>> |                   |
>> |                   |
>> |                   |
>> ---------------------
> 
> Are you missing some left and right part too? What are the dimensions of
> the text screen at bootup? What bootloader are you using? (It could be a
> bug in the boot up text screen dimension discovery).

It was just the height.  All numbers (done with printk's) look okay from
bootup. He gets 80 and 25 for ORIG_VIDEO_NUM_COLS and ORIG_VIDEO_NUM_LINES
respectively.

> 
>> I have a Silicon Graphics 1600sw LCD panel with a Number Nine Revolution 4
>> video card."
> 
> Does vgacon.c properly discovers that it is a VGA board?

Yes.

> 
>> This bug seems to be a glitch in the VGA core of this chipset.  Resizing
>> the screen triggers the mentioned bug.
> 
> Do vga-only games (like old DOS-mode games) work with it?
> 
>> The workaround is to make vgacon avoid calling vgacon_doresize() if the
>> display parameters did not change.
> 
> I.e. never call it, actually.
> 
>> A definitive fix will need to be provided by someone who knows and has the
>> hardware.
> 
> I'm not sure it is hardware-specific. Maybe you have a combination of
> vga bios/bootloader/vga=ask/... that prevents vgacon.c from properly
> discovering the dimensions of the text screen.

His console worked before linux-2.6.14-rc2.

Tony
