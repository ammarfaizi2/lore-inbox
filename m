Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbTIHMq0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 08:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTIHMq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 08:46:26 -0400
Received: from ejc.ecomda.com ([212.18.24.150]:62438 "EHLO ejc.ecomda.com")
	by vger.kernel.org with ESMTP id S261160AbTIHMqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 08:46:24 -0400
Subject: Re: possible GPL violation by Sigma Designs
From: Torgeir Veimo <torgeir@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1063024404.21084.7.camel@dhcp23.swansea.linux.org.uk>
References: <1062985742.3771.16.camel@africa.netenviron.com>
	 <1063024404.21084.7.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain
Message-Id: <1063025187.3284.55.camel@africa.netenviron.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Mon, 08 Sep 2003 13:46:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-08 at 13:33, Alan Cox wrote:
> On Llu, 2003-09-08 at 02:49, Torgeir Veimo wrote:
> > The Sigma Designs EM8500 is apparently a combined mpeg4 decoder and RISC
> > processor. I'd assume that they would be required to release source code
> > on request for their kernel, even if the code is executed on the EM8500
> > directly, as opposed being controller by a kernel driver running on a
> > separate processor?
> 
> If the EM8500 is running a linux kernel then they need to state that
> provide the offer of source code or provide the source and obey the GPL.
> I'd suspect if it runs Linux on the 8500 it runs Linux + apps and the
> interesting DVD stuff is the apps not the kernel however 8)

The romfs filesystem has a linux.bin.z kernel file, fipmodule.o and a
khwl.o file, both of which I think are modules. The khwl.o file seems to
be the driver. `strings khwl.o` reveals among other things:

(hwl0)minor_ioctl: REALMAGICHWL_IOCTL_CLEAR_MODULE_USE_COUNT done.
(hwl0)minor_ioctl: process %d enters (case %d) ----------------
(hwl0)minor_ioctl: unknown ioctl or feature not supported (see
REALMAGICHWL_FEATURES)
(hwl0)minor_ioctl: process %d leaves (case %d, return %d) ------
(hwl0)open done by %d (user count #%d)
(hwl0)close done by %d (user count #%d)
(hwl#)init_module: begun
realmagichwl0
(hwl#)init_module: devfs_register failed
(hwl#)init_module: device (%d:%d) registered in devfs
(hwl#)init_module: found JASPER
(hwl#)cleanup_module: begun
(hwl#)cleanup_module: done
...
DICOM_PackedPicBuf
Decoder_Config
Force_PanScanDefHorSize
...
Audio_PTSFifo
Audio_PTSSize
Audio_PTSRdPtr
Audio_Dec_Mode
Audio_CompDualOCfg_Mode
Audio_DynamicRange

The player is a file called mpegplayer.bin. 

uClinux supports module loading, doesn't it?
 
-- 
Torgeir Veimo <torgeir@pobox.com>

