Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263658AbTE3New (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 09:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbTE3New
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 09:34:52 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:63917 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263658AbTE3Neu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 09:34:50 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16087.24852.793344.859672@laputa.namesys.com>
Date: Fri, 30 May 2003 17:48:04 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Scott A Crosby <scrosby@cs.rice.edu>
Cc: linux-kernel@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
In-Reply-To: <oydbrxlbi2o.fsf@bert.cs.rice.edu>
References: <oydbrxlbi2o.fsf@bert.cs.rice.edu>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta11) "cabbage" XEmacs Lucid
X-Drdoom-Fodder: satan root CERT passwd crash
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott A Crosby writes:
 > Hello. We have analyzed this software to determine its vulnerability
 > to a new class of DoS attacks that related to a recent paper. ''Denial
 > of Service via Algorithmic Complexity Attacks.''
 > 
 > This paper discusses a new class of denial of service attacks that
 > work by exploiting the difference between average case performance and
 > worst-case performance. In an adversarial environment, the data
 > structures used by an application may be forced to experience their
 > worst case performance. For instance, hash tables are usually thought
 > of as being constant time operations, but with large numbers of
 > collisions will degrade to a linked list and may lead to a 100-10,000
 > times performance degradation. 

Another nice way to experience "worst case performance", is to create
deeply nested directory structure, like

0/1/2/3/4/.../99999/100000

try to unmount and see how shrink_dcache_parent/prune_dcache consume
100% of CPU without allowing preemption. Not recommended on a single
processor machine.

 >                                Because of the widespread use of hash
 > tables, the potential for attack is extremely widespread. Fortunately,
 > in many cases, other limits on the system limit the impact of these
 > attacks.
 > 

[...]

 > 
 > Scott

Nikita.
