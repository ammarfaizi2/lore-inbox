Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbSLQH7m>; Tue, 17 Dec 2002 02:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSLQH7l>; Tue, 17 Dec 2002 02:59:41 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:64011 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264822AbSLQH7k>; Tue, 17 Dec 2002 02:59:40 -0500
Message-ID: <3DFEDA14.7667AE5A@aitel.hist.no>
Date: Tue, 17 Dec 2002 09:02:28 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <20021215220132.GB6347@elf.ucw.cz> <200212160733.gBG7XhD67922@saturn.cs.uml.edu> <20021216111759.GA24196@atrey.karlin.mff.cuni.cz> <20021216175432.GA5094@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> 
> On Mon, Dec 16, 2002 at 12:17:59PM +0100, Pavel Machek wrote:
> > > Sure it's dirty. It's also fast, with the only overhead being
> > > a few NOPs that could get skipped on syscall return anyway.
> > > Patching overhead is negligible, since it only happens when a
> > > page is brought in fresh from the disk.
> > Yes but "read only" code changing under you... Should better be
> > avoided.
> 
> Programs that self verify their own CRC may get a little confused (are
> there any of these left?), but other than that, 'goto is better avoided'
> as well, but sometimes 'goto' is the best answer.

And then there's programs that store constants as parts of the code,
so that their constant-ness is enforced byt the mmu.

This can be taken further - the compiler can save space by looking
through the generated code and use an address in the code as the
constant if it happens to have the right value.  With some
bad luck it chooses the syscall sequence that it really don't expect 
to be modified.

Helge Hafting
