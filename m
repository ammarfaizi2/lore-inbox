Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbTKXKEf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 05:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbTKXKEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 05:04:35 -0500
Received: from mail.x-plor.com ([196.37.99.211]:65199 "EHLO
	x-plor-mail.jhb-xplor") by vger.kernel.org with ESMTP
	id S263697AbTKXKEd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 05:04:33 -0500
content-class: urn:content-classes:message
Subject: RE: New model of SanDisk compact flash not working
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Mon, 24 Nov 2003 12:08:55 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Message-ID: <0887314A0D67E14C8C255BEF09FC3D99501158@x-plor-mail.jhb-xplor>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: New model of SanDisk compact flash not working
Thread-Index: AcOycP6zHXdTdpBXRSOTH8eFU9rrmwAAUFSA
From: "gmlinux" <gmlinux@x-plor.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Nov 2003 10:08:55.0890 (UTC) FILETIME=[F855E320:01C3B272]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

The original SanDisk I checked passed 100%, it has been running in the
field now for about 6 months without any hassles. It is just this new
model that they have released.
The major problem is I have a release in about 2 weeks, which means I do
not have time to do testing on a new product, and we cannot get any of
the older versions.

hdc=flash is used to make the kernel scan for a slave when it detects a
flash disk. We are already using this option because we have two
SanDisks on the same bus, master and slave.

I thought IDE was a standard that a single driver would work with all
devices? I cannot understand how a new controller (if it really does
conform to the standards), cannot work.
It is working a little, because it responds to all the ATA interface
commands and returns readable information if you for example query the
status. Also, the kernel does detect the SANDISK CFB info string
correctly on boot.

Regards
  Garth



-----Original Message-----
From: Michael C. B. Ashley [mailto:mcba@phys.unsw.edu.au]
Sent: Monday, November 24, 2003 11:50 AM
To: gmlinux
Subject: re: New model of SanDisk compact flash not working


Hi Garth,

I have had lots of trouble with SanDisk CF disks. So much so that I have
given up on them and am using an alternative IDE solid state drive
(M-Systems IDE Plus - seems to work, I'm getting 8MB/sec from hdparm
-tT).

Have you tried "hdc=flash"?

If you search for "flash" in the IDE code you will find cryptic comments
about flash drives not properly implementing standards.

Good luck!
Michael
