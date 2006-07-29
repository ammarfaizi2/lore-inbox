Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWG2WSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWG2WSx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 18:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWG2WSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 18:18:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:36083 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750702AbWG2WSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 18:18:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pu2pbi8me4bcr6mfhZ5EuyyP4yzoyUPQA2zg3BCr+Mh+n13uzRxPlClEMQx1gRNuwXYGJ1C/Wa3AqE2dPNIXTjrHUR80wBErOeS+uhqgUSVbqTSwqRLRQIVEjzMXNsJAg5nhA3mhqRqtL9q06OyAaruS5VSF+uvS1Gjl09OCkfs=
Message-ID: <9a8748490607291518m59573244wac00486a64f6385b@mail.gmail.com>
Date: Sun, 30 Jul 2006 00:18:50 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Hans Reiser" <reiser@namesys.com>,
       "Alexander Viro" <viro@zeniv.linux.org.uk>,
       "Al Viro" <viro@ftp.linux.org.uk>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: possible recursive locking detected - while running fs operations in loops - 2.6.18-rc2-git5
In-Reply-To: <20060725232924.GU6452@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490607251516j1433306ek9c64cc84c0838f7b@mail.gmail.com>
	 <20060725232924.GU6452@schatzie.adilger.int>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/06, Andreas Dilger <adilger@clusterfs.com> wrote:
> On Jul 26, 2006  00:16 +0200, Jesper Juhl wrote:
> > What I did to provoke it was to run 6 different xterms (with a bash
> > shell) with the following loops in them in a test directory that was
> > initially empty :
> >
> > xterm1:   while true; do mkdir a; done
> > xterm2:   while true; do rmdir a; done
> > xterm3:   while true; do touch a/foo; done
> > xterm4:   while true; do find .; done
> > xterm5:   while true; do sync; sleep 1; done
> > xterm6:   while true; do rm -r a; done
>
> See racer test at ftp.lustre.org/pub/benchmarks/racer-lustre.tar.gz
>
> It does the above, but a bunch more things and is a truly pathalogical
> test script that does lots of "stupid user tricks", unlike normal tests
> which are only doing operations that expect to be successful.
>
> PS - during the racer.sh test run "rm" is known to segfault after hitting
>      an internal assertion, nobody is sure why.
> PPS- I don't know who wrote this program, it was originally posted by
>      someone not the author to linux-fsdevel or something.
>

Thanks. That's a nice little test suite.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
