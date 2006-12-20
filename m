Return-Path: <linux-kernel-owner+w=401wt.eu-S1754627AbWLTMB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbWLTMB2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754453AbWLTMB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:01:28 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1528 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbWLTMB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:01:28 -0500
Date: Wed, 20 Dec 2006 12:01:19 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Ralf Baechle <ralf@linux-mips.org>,
       Jeff Garzik <jgarzik@pobox.com>, Antonino Daplas <adaplas@pol.net>,
       James.Bottomley@SteelEye.com
cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org
Subject: [PATCH 2.6.20-rc1 00/10] TURBOchannel update to the driver model
Message-ID: <Pine.LNX.4.64N.0612182115550.10069@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 It has been much longer than expected, but finally it is here!  This 
series of patches converts support for the TURBOchannel bus to the driver 
model.  As a nice side effect, the generic part of the code is now really 
generic, that is no more dependencies on MIPS specifics under drivers/tc/ 
and platform specific code for MIPS got moved where it belongs.  As to 
whether other relevant platforms will add TURBOchannel support or not I 
cannot tell right now. ;-)

 All the changes have been successfully tested with a DECstation 5000/133 
and the necessary bits of additional hardware as appropriate.  Where 
drivers supporting different bus attachments were concerned, they were 
built for configurations enabling all the other buses supported and 
run-time checked if possible.

 And last but not least, thanks to James Simmons for beginning this work a 
while ago as his code was great to start with.

  Maciej
