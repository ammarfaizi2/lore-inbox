Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWEMM70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWEMM70 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWEMM7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:59:25 -0400
Received: from thunk.org ([69.25.196.29]:61155 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932421AbWEMM7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:59:24 -0400
Date: Sat, 13 May 2006 08:59:11 -0400
From: Theodore Tso <tytso@mit.edu>
To: Mark Rosenstand <mark@borkware.net>
Cc: Douglas McNaught <doug@mcnaught.org>, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
Message-ID: <20060513125911.GA2871@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Mark Rosenstand <mark@borkware.net>,
	Douglas McNaught <doug@mcnaught.org>, arjan@infradead.org,
	linux-kernel@vger.kernel.org
References: <20060513103841.B6683146AF@hunin.borkware.net> <1147517786.3217.0.camel@laptopd505.fenrus.org> <20060513110324.10A38146AF@hunin.borkware.net> <1147518432.3217.2.camel@laptopd505.fenrus.org> <87r72yi346.fsf@suzuka.mcnaught.org> <20060513112754.1CA99146AF@hunin.borkware.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513112754.1CA99146AF@hunin.borkware.net>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 01:27:54PM +0200, Mark Rosenstand wrote:
> > Every Unix I've ever seen works this way.  It'd be nice to have
> > unreadable executable scripts, but no one's ever done it.
> 
> According to
> http://www.faqs.org/faqs/unix-faq/faq/part4/section-7.html both
> 4.3BSD and SunOS have. I can confirm that it works on current BSD's
> as well.

Incorrect.  The FAQ stated that BSD4.3 and SunOS support executable
shell scripts, but both BSD 4.3 and SunOS required that the shell
scripts be readable.  I know, I've personally worked on BSD 4.3
systems and worked on BSD 4.3 source.  Read the FAQ more carefully....

Let's try this on Solaris:

1% uname -a
SunOS all-night-tool.mit.edu 5.10 Generic_118822-26 sun4u sparc
2% cat > test-exe
#!/bin/sh
echo "This is a test of a non-readable shell script"
3% chmod 111 test-exe
4% ls -l test-exe
   2 ---x--x--x   1 tytso    mit           63 May 13 08:56 test-exe*
5% ./test-exe
./test-exe: ./test-exe: cannot open
6% chmod 755 test-exe
7% ./test-exe
This is a test of a non-readable shell script

Any other questions?

						- Ted





