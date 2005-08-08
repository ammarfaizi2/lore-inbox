Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVHHOb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVHHOb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVHHOb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:31:57 -0400
Received: from mx1.suse.de ([195.135.220.2]:62430 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750893AbVHHOb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:31:56 -0400
Date: Mon, 8 Aug 2005 16:31:51 +0200
From: Olaf Hering <olh@suse.de>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, klibc@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: [klibc] Re: [PATCH - RFC] Move initramfs configuration to "General setup"
Message-ID: <20050808143151.GA6332@suse.de>
References: <20050808135936.GA9057@mars.ravnborg.org> <Pine.LNX.4.63.0508081610400.29195@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508081610400.29195@alpha.polcom.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Aug 08, Grzegorz Kulewski wrote:

> >From my recent experiments it looks like in order to be able to use 
> initramfs not compiled into the kernel image but loaded from separate file 
> by GRUB or LILO one must also build initrd into the kernel.

The file passed from the bootloader to the kernel, which is later
eventually recognized as an initrd, can be everything. But the kernel
code to deal with the memory range containing the file is behind
CONFIG_BLK_DEV_INITRD. The new config options should depend on
BLK_DEV_INITRD
