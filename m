Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286962AbSASTHj>; Sat, 19 Jan 2002 14:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286968AbSASTHa>; Sat, 19 Jan 2002 14:07:30 -0500
Received: from khms.westfalen.de ([62.153.201.243]:11478 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S286942AbSASTHQ>; Sat, 19 Jan 2002 14:07:16 -0500
Date: 19 Jan 2002 19:44:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8HBE1o7mw-B@khms.westfalen.de>
In-Reply-To: <Pine.GSO.4.21.0201190627310.3523-100000@weyl.math.psu.edu>
Subject: Re: rm-ing files with open file descriptors
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <a2bk6e$t2u$1@ncc1701.cistron.net> <Pine.GSO.4.21.0201190627310.3523-100000@weyl.math.psu.edu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@math.psu.edu (Alexander Viro)  wrote on 19.01.02 in <Pine.GSO.4.21.0201190627310.3523-100000@weyl.math.psu.edu>:

> On Sat, 19 Jan 2002, Miquel van Smoorenburg wrote:
>
> > This could be hacked around ofcourse in fs/namei.c, so I tried
> > it for fun. And indeed, with a minor correction it works:
> >
> > % perl flink.pl
> > Success.
> >
> > I now have a flink-test2.txt file. That is pretty cool ;)
>
> It's also a security hole.

It may well be one when going via /proc. But is it one when going via a  
(hypothetical) proper flink(2)? If so, why?

Note that every process who has a filehandle open for reading can already  
get at the file contents and write them to a completely new file, and  
every process who has it open for writing can already change its contents  
to everything it likes. So I can see read|write checks on the file handle.  
Also all the usual link(2) checks. What else could be a hole?

MfG Kai
