Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132418AbRDPXrU>; Mon, 16 Apr 2001 19:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132419AbRDPXrK>; Mon, 16 Apr 2001 19:47:10 -0400
Received: from mail.gci.com ([205.140.80.57]:25605 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S132418AbRDPXq4>;
	Mon, 16 Apr 2001 19:46:56 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA3150446DA08@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: esr@snark.thyrsus.com, linux-kernel@vger.kernel.org
Subject: RE: CML2 1.1.3 release announcement
Date: Mon, 16 Apr 2001 15:46:44 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It also appears that upon a re-configuration of 2.4.3 from 2.2.17:

> cd /usr/src/linux
> cp ../linux-2.2.17/.config .
> make oldconfig

where the old configuration did not include FrameBuffer support,
then performing an Xconfig to tweak some settings and enable FB,
no default fonts were allocated.  This is contrary to CML1 behavoir.

> grep ^CONFIG_FB .config
CONFIG_FB=y
CONFIG_FB_VESA=y
CONFIG_FB_MACH64=y


however CML1, after only selecting the applicable drivers gives:
> grep ^CONFIG_FB ~/myotherbox-2.4.3.config
CONFIG_FB=y
CONFIG_FB_VESA=y
CONFIG_FB_VGA16=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_VGA_PLANES=y

