Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbTIRCDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 22:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbTIRCDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 22:03:37 -0400
Received: from mhub15.lvs.dupont.com ([52.128.30.15]:49608 "EHLO
	mhub15.lvs.dupont.com") by vger.kernel.org with ESMTP
	id S262922AbTIRCDf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 22:03:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
Subject: Linux 2.4.18 Scheduler Bug?
Date: Wed, 17 Sep 2003 21:03:15 -0500
Message-Id: <EF9FD28280A17140A3366737EB698AD50BF2B2@jhms08.phibred.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux 2.4.18 Scheduler Bug?
Thread-Index: AcN9iQV/JcSBRx4oSVSGcsG5FIAddQ==
From: "Vander Velden, Kent" <kent.vandervelden@pioneer.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Sep 2003 02:03:15.0491 (UTC) FILETIME=[05A09F30:01C37D89]
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC: responses to my email.

On two seperate SMP machines I run two instances of two different programs, minimin.x and random_simplex.  Both instances of random_simplex are niced to 20 on both machines.  Both minimin.xand random_simplex are CPU bound processes.  On the first machine the processes are allocated CPU as would be expected (data taken from 'top'):

 

Linux cn103 2.4.18-18.8.0smp #1 SMP Wed Nov 13 23:11:20 EST 2002 i686 i686 i386 GNU/Linux

 

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND

25911 f459659   25   0  3452 3452  1032 R    94.3  0.1 167:13 minimin.x

25903 f459659   25   0  3604 3604  1072 R    93.4  0.1 168:03 minimin.x

26658 f493418   39  19  5396 5396  4188 R N   5.9  0.2   0:42 random_simplex

26682 f493418   39  19  5124 5124  4188 R N   5.9  0.1   0:42 random_simplex

 

However, on the second machine they are not:

 

Linux cn065 2.4.18-18.8.0smp #1 SMP Wed Nov 13 23:11:20 EST 2002 i686 i686 i386 GNU/Linux

 

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND

26881 f459659   25   0  3452 3452  1032 R    55.6  0.1 137:03 minimin.x

27630 f493418   39  19  5272 5272  4188 R N  50.6  0.2   4:37 random_simplex

27654 f493418   39  19  5124 5124  4188 R N  50.6  0.1   4:37 random_simplex

26873 f459659   25   0  3564 3564  1072 R    44.7  0.1 137:19 minimin.x

 

Renicing the processes has not affect.  Restarting the processes seems to help.  What might be

causing this?  Are there any know bugs in the SMP schechuler in 2.4.18 that might cause this? 

Is there a workaround or does a more recent kernel fix this?

 
Thanks.
 


This communication is for use by the intended recipient and contains 
information that may be privileged, confidential or copyrighted under
applicable law.  If you are not the intended recipient, you are hereby
formally notified that any use, copying or distribution of this e-mail,
in whole or in part, is strictly prohibited.  Please notify the sender
by return e-mail and delete this e-mail from your system.  Unless
explicitly and conspicuously designated as "E-Contract Intended",
this e-mail does not constitute a contract offer, a contract amendment,
or an acceptance of a contract offer.  This e-mail does not constitute
a consent to the use of sender's contact information for direct marketing
purposes or for transfers of data to third parties.

 Francais Deutsch Italiano  Espanol  Portugues  Japanese  Chinese  Korean

            http://www.DuPont.com/corp/email_disclaimer.html


