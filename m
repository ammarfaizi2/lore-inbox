Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317948AbSGLAYg>; Thu, 11 Jul 2002 20:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317949AbSGLAYf>; Thu, 11 Jul 2002 20:24:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20496 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317948AbSGLAYe>; Thu, 11 Jul 2002 20:24:34 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: IDE/ATAPI in 2.5
Date: 11 Jul 2002 17:27:11 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <agl7ov$p91$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I have suggested this before, and I haven't quite looked at this
in detail, but I would again like to consider the following,
especially given the changes in 2.5:

Please consider deprecating or removing ide-floppy/ide-tape/ide-cdrom
and treat all ATAPI devices as what they really are -- SCSI over IDE.
It is a source of no ending confusion that a Linux system will not
write CDs to an IDE CD-writer out of the box, for the simple reason
that cdrecord needs access to the generic packet interface, which is
only available in the nonstandard ide-scsi configuration.

There really seems to be no decent reason to treat ATAPI devices as
anything else.  I understand the ide-* drivers contain some
workarounds for specific devices, but those really should be moved to
their respective SCSI drivers anyway -- after all, manufacturers
readily slap IDE or SCSI interfaces on the same devices anyway.

Note that this is specific to ATAPI devices.  ATA hard drives are
another matter entirely.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
