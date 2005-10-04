Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbVJDRkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVJDRkP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVJDRkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:40:15 -0400
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:48534 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932533AbVJDRkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:40:13 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17218.48779.282910.692785@gargle.gargle.HOWL>
Date: Tue, 4 Oct 2005 21:40:27 +0400
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <20051004172338.GZ10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net>
	<54300000.1128297891@[10.10.2.4]>
	<20051003011041.GN6290@lkcl.net>
	<200510022028.07930.chase.venters@clientec.com>
	<20051004125955.GQ10538@lkcl.net>
	<17218.39427.421249.448094@gargle.gargle.HOWL>
	<20051004161702.GU10538@lkcl.net>
	<17218.47309.332739.836271@gargle.gargle.HOWL>
	<20051004172338.GZ10538@lkcl.net>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton writes:
 > On Tue, Oct 04, 2005 at 09:15:57PM +0400, Nikita Danilov wrote:
 > > Luke Kenneth Casson Leighton writes:
 > > 
 > > [...]
 > > 
 > >  > 
 > >  >  assuming that you have an intelligent programmer (or some really good
 > >  >  and working parallelisation tools) who really knows his threads?
 > > 
 > > Well, I'd like to have a hardware with CAS-n operation for one
 > > thing. 
 > 
 >  CAS - compare and swap - by CAS-n i presume that you mean effectively a
 >  SIMD CAS instruction?

An instruction that atomically compares and swaps n independent memory
locations with n given values. cas-1 (traditional compare-and-swap) is
enough to implement lock-less queue, cas-2 is enough to implement
double-linked lists, and was used by Synthesis lock-free kernel
(http://citeseer.ist.psu.edu/massalin91lockfree.html).

To be precise, cas-1 is theoretically enough to implement double-linked
lists too, but resulting algorithms are not pretty at all.

 > 
 > > But what would this buy us? 
 > 
 >  you do not say :)  i am genuinely interested to hear what it would buy.

Nothing. That was an instance of "rhetorical question", sorry that I
made not this clear enough.

 > 
 > > Having different kernel algorithms
 > > for x86 and mythical cas-n-able hardware is not viable.
 > 
 >  if i can get an NPTL .deb package for glibc for x86 only it would tend
 >  to imply that that isn't a valid conclusion: am i missing something?

Yes: this is Linux _Kernel_ mailing list, and I was talking about kernel
code and kernel algorithms.

 > 
 >  cheers,
 > 
 >  l.
 >  

Nikita.

 >  
