Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269688AbUHZXec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269688AbUHZXec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269762AbUHZXdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:33:44 -0400
Received: from jib.isi.edu ([128.9.128.193]:54144 "EHLO jib.isi.edu")
	by vger.kernel.org with ESMTP id S269688AbUHZXc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:32:57 -0400
Date: Thu, 26 Aug 2004 16:32:53 -0700
From: Craig Milo Rogers <rogers@isi.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Termination of the Philips Webcam Driver (pwc)
Message-ID: <20040826233244.GA1284@isi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	As a third party, I issue a plea for mediation.

	Over on the linux-usb-devel mailing list, a spat has arisin
between the Linux 2.6 USB maintainer, Greg K-H, and Nemosoft, the
author of the driver (drivers/usb/media/pwc*) for certain
Philips-based Web cameras.  As a result, Nemosoft has asked that his
driver be removed from the Linux 2.6 kernel.

	The driver is structured as two modules: an open-source
module, included in the standard Linux kernel for years, which
controls the basic operations of the camera chip, and a closed-source
module, distributed in object format independently of the Linux
kernel, that provides decompression services for proprietary codecs
that are used for higher-resolution modes in some Web cameras based on
this chip family.  A hook in the open-source driver allows
decompression modules (codec modules) (which may, after all, be either
open source or proprietary) to register with the main driver.

	Citing the fact that the only current use of the hook was to
register a non-open-source module, and citing a policy statement by
Linux Torvalds (see the discussion on the linux-usb-devel archive for
details), Greg K-H removed the hook from Nemosoft's in-kernel driver,
and Nemosoft withdrew his driver from Linux.

	As a not uninterested bystander (I just invested $200 of my
personal money in Logitech web cameras on the strength of the pwc
driver, based on Web research only two days old now!), I appeal for
higher-level arbitration in this issue.  I, personally, would prefer a
pure open-source kernel, and in fact, Nemosoft posted that he has at
this time the opportunity to discuss with Philips the possibility of
open-sourcing the codecs involved.  However, Greg K-H's unilateral
decision to excise the pwc codec hook has so infuriated Nemosoft that,
unless another maintainer for this driver steps forth, we may be left
with no Linux support at all for this popular family of web cameras.

					Craig Milo Rogers
