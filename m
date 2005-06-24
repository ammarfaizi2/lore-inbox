Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263146AbVFXXn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbVFXXn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 19:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbVFXXn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 19:43:57 -0400
Received: from mail.gmx.de ([213.165.64.20]:29321 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263146AbVFXXn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 19:43:26 -0400
X-Authenticated: #9500999
From: Daniel Arnold <arnomane@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 plugins
Date: Sat, 25 Jun 2005 01:43:16 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200506250143.17343.arnomane@gmx.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I looked at the whole thread regarding "reiser4 plugins" via Kerneltrap and 
felt myself committed to say thank you to those people like Hans that have a 
vision and are working hard to let it come true (and not only talk about what 
might could be done ;-) ).

See the following comments as a pure outsiders user perspective view (Note: I 
have virtually no knowledge of the technical kernel internals) of the 
possibilities that Reiser4 and related technologies provide for our beloved 
Linux operating system as I fear that you missed this view somehow in your 
heated debate:

Although I'm currently using ReiserFS v3 at my (Suse) Linux box (and am happy 
that it uses my small hard disk space better than other file systems and that 
I could always repair the data on the file system in some minutes at least in 
large parts in case my _hardware_ caused a system crash; I had a evil 
graphics card...), I'm very excited of the possibilities v4 provides and 
wonder why there are people at LKML that don't see those possibilities 
although they have a lot of more knowledge than I have on files system issues 
(as I'm mainly a user). Perhapes some are beside technical concerns trapped 
into to a "traditional Unix religion" (for me this is the real reason why 
e.g. the free BSD's are constantly forked, as everyone thinks he has found 
the only true way in the "Unix religion").

Here are only some possibilities that come into my mind regarding Reiser4:

One big thing are all the nice applications that want databases like MySQL. As 
they need that extra database software with its own tools and structures they 
are often too complicated for a normal end user. Having the same software 
using an intelligent file system without need for a special database would be 
a big step in end user usability especially but not only at the desktop. And 
of course you can easily manipulate your database with easy standard tools 
like a file manager or from command line like cp, mv, rm which would be again 
a big step back to simplicity.

Another idea is a CVS-like revision file system. Especially in /etc/ this 
would help a lot... Imagine a revision-plugin for Reiser4: This system would 
be self documenting as you don't need to keep in mind where, when, what you 
changed (and for system scripts it would be easier to track the manual 
manipulations; especially a problem at system upgrades). You could easily 
make a diff of two revisions of a file e.g. for /etc/squid/squid.conf (a huge 
single config file) with standard command line tools like diff (like 
"diff /etc/squid/squid.conf/rev-0 /etc/squid/squid.conf/rev-current").

Another possibility would be e.g. replacing the RPM-database by a structure in 
the Reiser4 file system. Imagine the structure of the rpm database which 
software is installed sitting below /etc/packages/, e.g. 
in /etc/packages/apache/. With removing the /etc/packages/apache/ directory a 
clever Reiser4-plugin would instantly remove the whole package (don't know 
how to handle the problem of executing necessary system scripts during that 
procedure though). That this idea is highly demanded can be seen on Apple 
computers and on a wired approach at a new FreeBSD distribution called 
PC-BSD, where everything of a application is installed in a own separate 
directory as on Windows...

Of course there are competiting approaches to this problem via hiding the 
database structure to the user and reinventing again the file system level as 
e.g. FUSE (which is/was also controversial at LKML but also highly demanded by 
end users). You could also mount a rpm database with a proper FUSE-plugin and 
let it look like a file system but this approach is not that elegant, needs a 
lot more software than the "filesystem as a database vision" and has of course 
poor performance by design compared to a direct solution like Reiser4.

And even FUSE is higly demanded as you can see e.g. with the KIO-Slaves of KDE 
where the filesystem view is implemented even in a higher level (to my 
knowledge KIO only exists as KDE needed a solution that works right now and 
not after many flames and discussions about a system like FUSE).

So I personally see FUSE and Reiser4 somewhat related and beeing objected by 
some people at LKML beside implementational problems by the same reasons of 
"traditional" thinking.

My personal vision would be using FUSE as a transition tool for changing 
existing structures back to the file system style and for mounting 
non-traditional remote database structures (as SSH/SFTP or IMAP like it is 
already done by the KIO-system in KDE) and Reiser4-plugins for sophisticated 
structures that enable direct fast local database access without the need of 
additional software.

Both ideas would be the killer feature of Linux desktops if used in 
applications on larger scale.

So I wish you very much luck with getting this finally into the Linux 2.6 main 
kernel as this software works right now and is needed right now. There is 
always room for later tuning in which kernel layer a specific function has to 
be...

Have fun,
Daniel Arnold
