Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbRGTQqH>; Fri, 20 Jul 2001 12:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267105AbRGTQp5>; Fri, 20 Jul 2001 12:45:57 -0400
Received: from sesys.exodata.se ([193.44.92.66]:5848 "EHLO
	sesys.se.transtec.de") by vger.kernel.org with ESMTP
	id <S267102AbRGTQpn> convert rfc822-to-8bit; Fri, 20 Jul 2001 12:45:43 -0400
From: Roland Fehrenbacher <rfehrenb@transtec.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <15192.20739.221470.366449@gargle.gargle.HOWL>
Date: Fri, 20 Jul 2001 17:40:51 +0200
Subject: qlogicfc driver
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I am testing a SAN setup with a Fibre Channel RAID Controller (GMR) connected
to a QLA2200/QLA2100 via Gadzoox Cappelix Switches. The RAID controller
supports 32 LUNs on configurable SCSI target Ids. In the present case I have 3
RAID sets with pairs (SCSI Id, LUN) (0, 0) (0, 1) (1, 0), i.e. two drives with
LUN 0 and one with LUN 1. While the controller itself sees all the 3 drives
when booting up, under Linux I am only able to see the LUN 0 drives.

Kernel is stock 2.4.6 using the qlogicfc driver. I also tried to set
max_scsi_luns=32, even though the default of 8 should be enough. No success.
Of course, support for multiple LUNs is enabled in the kernel. By the way,
using the beta driver on the qlogic site (qla2x00src-v4.27Beta.tgz) also
doesn't help. So the issue might not even be driver related.

Any ideas anyone?

Thanks.

Cheers,

Roland

----
Roland Fehrenbacher
transtec AG
Waldhörnlestrasse 18
D-72072 Tübingen
Tel.: +49(0)7071/703-320
Fax: +49(0)7071/703-90320
EMail: Roland.Fehrenbacher@transtec.de
http://www.transtec.de
