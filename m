Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbUKHVNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbUKHVNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUKHVKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:10:24 -0500
Received: from quechua.inka.de ([193.197.184.2]:40616 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261233AbUKHVHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:07:09 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Why my computer freeze completely with xawtv ?
References: <20041107224621.GB5360@magma.epfl.ch> <418EB58A.7080309@kolivas.org> <20041108000229.GC5360@magma.epfl.ch> <418EB8EB.30405@kolivas.org> <20041108003323.GE5360@magma.epfl.ch> <418EBFE5.5080903@kolivas.org> <Pine.LNX.4.60.0411080919220.32677@alpha.polcom.net>
Organization: private Linux site, southern Germany
Date: Mon, 08 Nov 2004 21:57:13 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E1CRGZd-0002ss-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect two things:
> - there is some bug in bttv and similar drivers (DVB) that corrupts memory
> related with internal mm and vfs structures or does something equally bad,
> - or maybe PCI bandwitch is overflowed, but I do not think it should
> happen.

This (first alternative) sounds related to the problem I had with DVB;
I got visible corruption of video memory when using xawtv on the DVB
video device using Xv on a G550. The cause might lie in either of:
- Hardware/AV7110 firmware
- Kernel DVB driver (probably: AV7110 videodevice part), tried many versions
- Xfree86 XV-over-videodevice driver, tried several versions
- Xfree86 MGA driver, tried several versions

Never found the cause, but the problem went away with disabling the Xv
extension (now using video overlay mode).

Olaf

