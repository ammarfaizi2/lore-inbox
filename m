Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbVITHyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbVITHyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbVITHyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:54:51 -0400
Received: from zorg.st.net.au ([203.16.233.9]:20611 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S964911AbVITHyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:54:51 -0400
Message-ID: <432FC066.8030806@torque.net>
Date: Tue, 20 Sep 2005 17:55:18 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org, tomfa@debian.org, kumba@gentoo.org
Subject: [ANNOUNCE] sdparm 0.95
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sdparm is a command line utility designed to get and set
SCSI device parameters (cf hdparm for ATA disks). Apart
from SCSI devices (e.g. disks, tapes and enclosures) sdparm
can be used on any device that uses a SCSI command set.
Virtually all CD/DVD drives use the SCSI MMC set irrespective
of the transport. sdparm also can decode VPD pages including
the device identification page. Commands to start and stop
the media; and load and unload removable media are supported.
sdparm can be used in both the lk 2.4 and 2.6 series.

This release adds the decoding of 5 more Vital Product Data
(VPD) pages. Most of the rest of the changes are bug fixes.

For more information and downloads see:
http://www.torque.net/sg/sdparm.html

ChangeLog for sdparm-0.95 [20050920]
  - add debian directory (for builds)
  - add decode for extended inquiry data VPD page
  - add decode for management network addresses VPD page
  - add decode for mode page policy VPD page
  - add decode for ATA information VPD page
  - add decode for Block limits VPD page
  - fix DRA and LBCSS bits in caching mode page
  - sync with SPC-4 rev 02
  - add EBACKERR in Informational exceptions mode page
  - add some defensive code into SCSI INQUIRY response processing
  - about 10 fixes to mode page items as a result of chk_sdparm_data
    <see notes.txt file for more information>
  - when changing mode pages, check modification position does not
    exceed actual page length
  - process '-p' option last since it depends on '-t' and '-i'
    - output available arguments when '-p' or '-t' arguments
      don't match
  - fix command line problem with '--dbd', '--defaults' and
    '--dummy'

Doug Gilbert
