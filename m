Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbTIJMaf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 08:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbTIJMaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 08:30:35 -0400
Received: from pf138.torun.sdi.tpnet.pl ([213.76.207.138]:40719 "EHLO
	centaur.culm.net") by vger.kernel.org with ESMTP id S262857AbTIJMae convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 08:30:34 -0400
From: Witold Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.4] siimage locks hard on high load
Date: Fri, 12 Sep 2003 13:44:43 +0200
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309121344.43573.adasi@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got Asus a7n8x deluxe with on-board Silicon Image SATA and 2xBarracuda 
120GB connected to it in software RAID array.
On high disk load (e.g. cp -Rf /usr/src/linux somewhere_else) kernel locks 
hard after about 10 seconds (magic sysrq is not working).
It happens only when DMA is enabled. 
/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 16 (on)
 geometry     = 14593/255/63, sectors = 234441648, start = 0

Also, I'm not really satisfied with speed of this array:
/dev/md1:
 Timing buffered disk reads:  64 MB in  1.77 seconds = 36.16 MB/sec
Any solutions/fixes?
-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net
