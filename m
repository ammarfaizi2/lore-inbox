Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286047AbRLHXMo>; Sat, 8 Dec 2001 18:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286046AbRLHXMe>; Sat, 8 Dec 2001 18:12:34 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:24075 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S286047AbRLHXMb>; Sat, 8 Dec 2001 18:12:31 -0500
Path: Home.Lunix!not-for-mail
Subject: Re: File copy system call proposal
Date: Sat, 8 Dec 2001 23:11:13 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <1007782956.355.2.camel@quinn.rcn.nmt.edu>
    <1007833194.17577.0.camel@buffy>
    <1007839431.371.0.camel@quinn.rcn.nmt.edu>
NNTP-Posting-Host: kali.eth
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 1007853073 18632 10.253.0.3 (8 Dec 2001
    23:11:13 GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Sat, 8 Dec 2001 23:11:13 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:131556
X-Mailer: Perl5 Mail::Internet v1.33
Message-Id: <9uu6mg$i68$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1007839431.371.0.camel@quinn.rcn.nmt.edu>,
	Quinn Harris <quinn@nmt.edu> writes:
> I wasn't aware of the sendfile system call.  But it apears that just
> like the mmap, write method suggested by H. Peter Anvin a memory copy is
> still performed when copying files from discs to duplicate the data for
> the buffer cache.  This would undoubtedly be faster than repeatedly
> calling read and write as it avoids one mem copy.  Yet GNU
> fileutils-4.1, that cp and install are part of, uses the read/write
> method.  I expect this is primarily because of portability issues but I
> wouldn't think the use of mmap would cause portability issues.

It does in fact. On some systems locks and mmaps are mutually exclusive.
