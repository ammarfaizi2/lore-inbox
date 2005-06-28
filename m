Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVF1DXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVF1DXS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 23:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVF1DXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 23:23:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262491AbVF1DXK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 23:23:10 -0400
Date: Mon, 27 Jun 2005 20:22:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?Um9n6XJpbw==?= Brito <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: Problems with Firewire and -mm kernels (was: Re: 2.6.12-mm2)
Message-Id: <20050627202226.43ebd761.akpm@osdl.org>
In-Reply-To: <20050628010052.GA3947@ime.usp.br>
References: <20050626040329.3849cf68.akpm@osdl.org>
	<42BE99C3.9080307@trex.wsi.edu.pl>
	<20050627025059.GC10920@ime.usp.br>
	<20050627164540.7ded07fc.akpm@osdl.org>
	<20050628010052.GA3947@ime.usp.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito <rbrito@ime.usp.br> wrote:
>
> On Jun 27 2005, Andrew Morton wrote:
>  > Could you please generate the dmesg output from 2.6.12 and 2.6.12-mm2 and,
>  > if there are any relevant-looking differences, send them?
> 
>  Ok, I put them both on <http://www.ime.usp.br/~rbrito/bug/>.

Great, here we are:

-ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0050c501e00010e8]
+ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0050c501e00010e8]
+ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
+ieee1394: Node changed: 0-01:1023 -> 0-00:1023
 ieee1394: Node changed: 0-00:1023 -> 0-01:1023
 SCSI subsystem initialized
 sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
@@ -300,14 +308,6 @@
 ieee1394: sbp2: Logged into SBP-2 device
 ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
   Vendor: ST316002  Model: 1A                Rev: 3.06
-  Type:   Direct-Access                      ANSI SCSI revision: 06
-SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
-sda: asking for cache data failed
-sda: assuming drive cache: write through
-SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
-sda: asking for cache data failed
-sda: assuming drive cache: write through
- sda: [mac] sda1 sda2 sda3 sda4
-Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
+  Type:   Unknown                            ANSI SCSI revision: 04
 ieee1394: Node changed: 0-01:1023 -> 0-00:1023
 ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0050c501e00010e8]

Could the 1394 guys please suggest what might have caused this?
