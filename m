Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbSKEWnt>; Tue, 5 Nov 2002 17:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265231AbSKEWnt>; Tue, 5 Nov 2002 17:43:49 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:65264 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S265230AbSKEWns>; Tue, 5 Nov 2002 17:43:48 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15816.19206.959160.739312@wombat.chubb.wattle.id.au>
Date: Wed, 6 Nov 2002 09:49:42 +1100
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: jw schultz <jw@pegasys.ws>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
In-Reply-To: <993103655@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Martin" == Martin J Bligh <mbligh@aracnet.com> writes:

>> And i'd still keep environ seperate.  I'm inclined to think ps
>> should never have presented it in the first place.  This is the
>> direction i (for what it's worth) favor.

Martin> If it doesn't need it then sure, otherwise just dump whatever
Martin> it needs in there. The seperate files would still be there
Martin> too.
 

Why not make an mmapable file in /proc  with everything in it?
It can be sparse, so have the first part a bit map to say what
processes are active, then just look at the bits you need.
That gets rid of all but the open and mmap system call.

Peter C
