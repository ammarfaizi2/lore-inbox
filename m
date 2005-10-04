Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbVJDPEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVJDPEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVJDPEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:04:30 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:32647 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932525AbVJDPE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:04:29 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17218.39427.421249.448094@gargle.gargle.HOWL>
Date: Tue, 4 Oct 2005 19:04:35 +0400
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Newsgroups: gmane.linux.kernel
In-Reply-To: <20051004125955.GQ10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net>
	<54300000.1128297891@[10.10.2.4]>
	<20051003011041.GN6290@lkcl.net>
	<200510022028.07930.chase.venters@clientec.com>
	<20051004125955.GQ10538@lkcl.net>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton writes:
 > On Sun, Oct 02, 2005 at 08:27:45PM -0500, Chase Venters wrote:
 > 
 > > The bottom line is that the application developers need to start being clever 
 > > with threads. 
 > 
 >  yep!  ah.  but.  see this:
 > 
 >  http://lists.samba.org/archive/samba-technical/2004-December/038300.html
 > 
 >  and think what would happen if glibc had hardware-support for
 >  semaphores and mutexes.

Let me guess... nothing? Overhead of locking depends on data-structures
used by application/library and their access patterns: one thread has to
wait for another to finish with the shared resource. Implementing
locking in hardware is going to change nothing here (barring really
stupid implementations of locking primitives). Especially as we are
talking about blocking primitives, like pthread semaphore or mutex: an
entry into the scheduler will by far outweigh any advantages of
raw-metal synchronization.

 > 
 > > I think I remember some interesting rumors about Perl 6, for 
 > > example, including 'autothreading' support - the idea that your optimizer 
 > > could be smart enough to identify certain work that can go parallel.

Fortran people automatically parallelize loops for a _long_ time.

 > 
 >  http://www.ics.ele.tue.nl/~sander/publications.php
 >  http://portal.acm.org/citation.cfm?id=582068
 >  http://csdl.computer.org/comp/proceedings/acsd/2003/1887/00/18870237.pdf
 > 
 >  to get the above references, put in "holland parallel code
 >  analysis tools" into google.com.

PS: I wonder why Luke Kenneth Casson Leighton, Esq., while failing to
spell the Grandeur of his Appellative with the full Capitalization in
not a single From header humble readers of this Thread have a rare Honor
to witness, insists on referring to his interlocutors in minuscule only?

Does this correlate with an abnormally frequent usage of word
"condescending" in this discussion?

Nikita.
