Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUG2JSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUG2JSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 05:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUG2JSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 05:18:25 -0400
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:5774 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262730AbUG2JSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 05:18:23 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16648.49328.924306.9838@wombat.chubb.wattle.id.au>
Date: Thu, 29 Jul 2004 19:17:36 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, peter@chubb.wattle.id.au,
       viro@parcelfarce.linux.theplanet.co.uk, davem@redhat.com, cw@f00f.org,
       linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
In-Reply-To: <20040729020252.0eaed212.akpm@osdl.org>
References: <233602095@toto.iv>
	<16648.10711.200049.616183@wombat.chubb.wattle.id.au>
	<20040728154523.20713ef1.davem@redhat.com>
	<20040729000837.GA24956@taniwha.stupidest.org>
	<20040728171414.5de8da96.davem@redhat.com>
	<20040729002924.GK12308@parcelfarce.linux.theplanet.co.uk>
	<16648.42669.907048.112765@wombat.chubb.wattle.id.au>
	<20040729004242.7601f777.akpm@osdl.org>
	<20040729014940.7f1e3315.pj@sgi.com>
	<20040729020252.0eaed212.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Paul Jackson <pj@sgi.com> wrote:
>>  Andrew wrote: > hmm.  Here's a Pentium III profile ...
>> 
>> What conclusion do your draw from this profile?

Andrew> At a quick squint: we spend about 10% of total system time in
Andrew> those copy functions.  If we halve their runtime (which would
Andrew> be good), we don't gain much.

And the proposal only removes one of the three copies, so you're
probably looking at around a 30% rather than a 50% reduction in the
10%.  Plus whatever knock on effects there might be from different
cache usage.

Is it worth the effort, and added complexity?  Unless there's some
other architecture where the memcpys are really expensive, the answer
at present appears to be, no.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
 





