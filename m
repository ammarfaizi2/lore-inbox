Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUCPSQX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUCPSQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:16:23 -0500
Received: from scrye.com ([216.17.180.1]:59297 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S261184AbUCPSQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:16:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Mar 2004 11:16:09 -0700
From: Kevin Fenzi <kevin@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Subject: Re: Dealing with swsusp vs. pmdisk
References: <20040312224645.GA326@elf.ucw.cz>
	<20040313004756.GB5115@thunk.org>
	<20040313122819.GB3084@openzaurus.ucw.cz>
	<m2d67dr98y.fsf@tnuctip.rychter.com>
From: Kevin Fenzi <kevin@scrye.com>
Message-Id: <20040316181612.91F9DB617A@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Jan" == Jan Rychter <jan@rychter.com> writes:

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:
Jan> [...]  Theodore Ts'o <tytso@mit.edu>:
>>> Pavel, what do you think of the swsusp2 patch, BTW?  My biggest
>>> complaint about it is that since it's maintained outside of the
>>> kernel, it's constantly behind about 0.75 revisions behind the
>>> latest 2.6 release.  The feature set of swsusp2, if they can ever
>>> get it completely bugfree(tm) is certainly impressive.

Pavel> My biggest problem with swsusp2 is that it is big. Also last
Pavel> time I looked it had some ugly hooks sprinkled all over the
Pavel> kernel. Then there are some features I don't like (graphical
Pavel> screens with progress, escape-to-abort) and
Pavel> ithasvariableslikethis. OTOH it supports highmem and smp.

Jan> It also has the advantage of working extremely reliably on 2.4
Jan> (and a large part of the code base is shared, so that's a
Jan> significant data point). I couldn't get it to crash or do
Jan> anything bad for months now, and I'm doing at least several
Jan> suspend/resumes a day on my laptop.

It's been working pretty well on 2.6 for me too. 2.4 was very stable
with it, 2.6 has been less so but is getting there fast. 

Jan> Also, thanks to the excellent compression feature, suspend/resume
Jan> times are very short and in fact competitive with suspend-to-ram
Jan> schemes.

Seconded. With the compression it takes about 15 seconds for my 1gb
memory laptop to suspend and about 15 seconds to resume. This is much
much better than the hardware hibernate my old laptop used to have in
bios. 

Jan> I think it's better not to mix personal preferences (such as the
Jan> escape-to-abort thing) with technical discussions. On a practical
Jan> level, swsusp2 is the only implementation which works reliably,
Jan> does its job very well, and has a responsive maintainer willing
Jan> to fix problems as they arise.

I tried pmdisk and swsusp1 a while back... I couldn't get either to
come back from suspend. swsusp2 is _much_ more reliable for me. 

I would love to see swsusp2 the only implementation in the kernel... 

Just my 2cents. 

Jan> --J.

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFAV0Rs3imCezTjY0ERAgEqAKCDe8mNAIywP6kfn8gUqqDRFqvJUQCeIJTr
82Apf+UlCk8jJlxgeTo1WFo=
=62Qn
-----END PGP SIGNATURE-----
