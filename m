Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWDROlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWDROlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWDROlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:41:06 -0400
Received: from mail-gw2.adaptec.com ([216.52.22.42]:30181 "EHLO
	aimspam2.adaptec.com") by vger.kernel.org with ESMTP
	id S932154AbWDROlE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:41:04 -0400
X-ASG-Debug-ID: 1145371454-26317-198-0
X-Barracuda-URL: http://192.168.92.161:8000/cgi-bin/mark.cgi
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
X-ASG-Orig-Subj: RE: HEADS UP for gdth driver users
Subject: RE: HEADS UP for gdth driver users
Date: Tue, 18 Apr 2006 16:41:02 +0200
Message-ID: <EF6AF37986D67948AD48624A3E5D93AFAA95FD@mtce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HEADS UP for gdth driver users
Thread-Index: AcZCsv/B8NzQ1nn/QDC/U+m8qk7CyAgNyuqQ
From: "Leubner, Achim" <Achim_Leubner@adaptec.com>
To: "Christoph Hellwig" <hch@lst.de>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=3.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.11010
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The patch looks good for 2.6.17-rc1. Christoph, did you already make the second patch for the real switchover? 
Will only the scsi_allocate_request()/scsi_do_req()/scsi_release_request() be removed in the next kernel releases? - I'm wondering if I could use the scsi_get_command()/scsi_put_command() functions to get a Scsi_Cmnd struct. and to send it to the gdth_queuecommand()/gdth_next(). I'm willing to make and test the second patch but please give me some hints what functions you plan to kill and what function we can still use. 

Thanks & Regards,
Achim 

=======================
Achim Leubner
Software Engineer / RAID drivers
ICP vortex GmbH / Adaptec Inc.
Phone: +49-351-8718291
 

-----Original Message-----
From: Christoph Hellwig [mailto:hch@lst.de] 
Sent: Mittwoch, 8. März 2006 14:20
To: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Leubner, Achim
Subject: HEADS UP for gdth driver users

Hi folks,

the gdth driver is the only driver using (and in this case abusing) the
scsi_request interface we plan to kill for 2.6.17.  I've sent a patch
that's a first step to convert the driver away from it a few weeks ago
but didn't get any response.  I urgently need testers to keep the driver
for 2.6.17+.  Else it'll be marked broken until we get a person to help
testing the changes needed to resurrect it.


