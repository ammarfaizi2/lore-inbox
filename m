Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTEOXdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 19:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264142AbTEOXdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 19:33:24 -0400
Received: from c16805.randw1.nsw.optusnet.com.au ([210.49.26.171]:20869 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S264037AbTEOXdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 19:33:22 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16068.9842.856760.712288@wombat.chubb.wattle.id.au>
Date: Fri, 16 May 2003 09:44:50 +1000
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: David Howells <dhowells@warthog.cambridge.redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Garance A Drosihn <drosih@rpi.edu>, Jan Harkes <jaharkes@cs.cmu.edu>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2 
In-Reply-To: <499763005@toto.iv>
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "chas" == chas williams <chas@locutus.cmf.nrl.navy.mil> writes:

chas> In message <6445.1053005715@warthog.warthog>,David Howells
chas> writes:
>> Where's this 1:1 come from? PAGs aren't 1:1 with processes, nor are
>> they 1:1 with users.
>> 
>> I've tried to implement them as I understand the design information
>> I could find (which specified that any process could belong to a
>> single PAG). From the comments that have been made, it seems that
>> each user needs some sort of fallback token set for any process
>> that doesn't have a PAG.

chas> PAGs shouldnt be 1:1 with processes or users.  They are closer
chas> in nature to process groups.  However, a process wouldnt loose

PAGs as you describe them are beginning to sound like a Cray `job',
although used for a different purpose.

Each process had a jobid in addition to its other IDs.  This was set
at login or by NQS (or by a few other privileged processes), initially
identical to the session ID.  After that, setsid(), setpgid(),
setpgrp() etc., would not change the job ID.

The job ID was used for accounting and resource managemment, IIRC.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
