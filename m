Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTEGPhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTEGPhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:37:14 -0400
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:16532 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id S263723AbTEGPhM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:37:12 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: problems after upgrading from 2.4.20-pre7 to 2.4.21-rc1 (maybe nfs related)
Date: Wed, 7 May 2003 10:49:45 -0500
Message-ID: <B578DAA4FD40684793C953B491D4879110D80D@umr-mail7.umr.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: problems after upgrading from 2.4.20-pre7 to 2.4.21-rc1 (maybe nfs related)
Thread-Index: AcMUsEhhElbfwlUMTSCf0O879F8u9Q==
From: "Neulinger, Nathan" <nneul@umr.edu>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warning up front - I have very little info here, I'll try to narrow
down, but I'm just tossing out in case it rings a bell.

Basically, upgrading my network install (solaris,redhat) server from
2.4.20-pre7 to 2.4.21-rc1 resulted in the solaris nfs install no longer
being functional. 

Both before and after the kernel is running with the following patches:
	2.4.20: 
		kdb
		couple minor defaults changes like sem, console
blanking, etc.
		vlan frame size changes to intel e100 drivers
		ip-fragment order reversal - send in ascending not
descending order (needed for crappy install-time solaris 2.7 kernels)

	2.4.21-rc1:
		same except w/o kdb

When installing with the new kernel, everything looks like it's working,
and it appears to be going through the nfs activity just fine but very
early on in the install process (while it's still displaying the kernel
startup messages), it just stops talking to the nfs server and appears
hard-locked (stop-a no longer does anything). One odd thing is that it
looks like it's trying to write to the read-only nfs export when booted
with 2.4.21. One thing that popped to mind is that maybe a return code
or other server response behavior was changed in nfsd and the client no
longer realizes it's on a RO filesystem or something like that.

Like I said, I don't have much information at the moment, will try and
diagnose a bit further and pass along more information when I have it.
If the above rings any bells, please pass along any info you have.

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216
