Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318790AbSICQig>; Tue, 3 Sep 2002 12:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318811AbSICQig>; Tue, 3 Sep 2002 12:38:36 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:56335 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S318790AbSICQif>; Tue, 3 Sep 2002 12:38:35 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15732.59029.941417.550708@laputa.namesys.com>
Date: Tue, 3 Sep 2002 20:43:01 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
In-Reply-To: <Pine.LNX.4.44.0209030113420.12861-100000@kiwi.transmeta.com>
References: <p73u1l7qbxs.fsf@oldwotan.suse.de>
	<Pine.LNX.4.44.0209030113420.12861-100000@kiwi.transmeta.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Drdoom-Fodder: crash security CERT crypt passwd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > 
 > 
 > On 3 Sep 2002, Andi Kleen wrote:
 > >
 > > x86-64 does that already. I did it originally to fix some printk warnings.
 > > But it caused even more. I didn't bother then to change it back. Doesn't
 > > seem to have too many bad side effects at least.
 > 
 > The printk warnings should be easy to fix once everybody uses the same
 > types - I think we right now have workarounds exactly for 64-bit machines
 > where w check BITS_PER_LONG and use different formats for them (exactly
 > because they historically have _not_ had the same types as the 32-bit
 > machines).
 > 
 > However, if anybody on the list is hacking gcc, the best option really
 > would be to just allow better control over gcc printf formats. I have
 > wanted that in user space too at times. And it doesn't matter if it only

See <printf.h>: register_printf_function(). -Wformat doesn't know about
new specifiers, though.

 > happens in new versions of gcc - we can disable the warning altogether for
 > old gcc's, as long as enough people have the new gcc to catch new
 > offenders..
 > 
 > (I'd _love_ to be able to add printk modifiers for other common types in
 > the kernel, like doing the NIPQUAD thing etc inside printk() instead of
 > having it pollute the callers. All of which has been avoided because of
 > the hardcoded gcc format warning..)
 > 
 > 			Linus

Nikita.

 > 
