Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVBXGQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVBXGQb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 01:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVBXGQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 01:16:31 -0500
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:32424 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261848AbVBXGLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 01:11:25 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] I8K driver facelift
Date: Thu, 24 Feb 2005 01:10:16 -0500
User-Agent: KMail/1.7.2
Cc: Massimo Dal Zotto <dz@debian.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502240110.16521.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here are some changes that freshen I8K driver (Dell Inspiron/Latitude
platform driver). The patches have been tested on Inspiron 8100.

i8k-lindent.patch
- pass the driver through Lindent to comply with CondingStyle requirements
  (4 spaces vs. TAB indentation)

i8k-use-dmi.patch
- use standard DMI handling functions instead of homemade ones. The driver
  now requires DMI data to match list of supported models - this way driver
  can be safely enabled without fear of it poking into SMM code on wrong
  box. DMI checks can be ignored with i8k.ignore_dmi option.   

i8k-seqfile.patch
- switch proc handlig code to seq_file instead of having custom read
  function splitting output to fit into user's buffer.

i8k-cleanup.patch
- use module_{init|exit} instead of old-style module intialization code,
  some formatting changes.

i8k-sysfs.patch
- make i8k a platform device and export temperatiure and both fan states
  as sysfs attributes. Wringing into fan1_state and fan2_state attributes
  allows switching fans on and off without need for special utility.

Please consider for inclusion.

Thanks!

-- 
Dmitry
