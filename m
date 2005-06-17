Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVFQQLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVFQQLm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 12:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVFQQLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 12:11:42 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7187 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262006AbVFQQLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 12:11:40 -0400
Message-Id: <200506171611.j5HGBFY8012609@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Robert Love <rml@novell.com>
Cc: Chris Friesen <cfriesen@nortel.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Zach Brown <zab@zabbo.net>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] inotify, improved. 
In-Reply-To: Your message of "Fri, 17 Jun 2005 11:44:38 EDT."
             <1119023078.3949.115.camel@betsy> 
From: Valdis.Kletnieks@vt.edu
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy> <42B227B5.3090509@yahoo.com.au> <1118972109.7280.13.camel@phantasy> <1119021336.3949.104.camel@betsy> <42B2EE31.9060709@nortel.com>
            <1119023078.3949.115.camel@betsy>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119024674_7562P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Jun 2005 12:11:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119024674_7562P
Content-Type: text/plain; charset=us-ascii

On Fri, 17 Jun 2005 11:44:38 EDT, Robert Love said:
> I have been hesitant, though.  I do not want feature creep to be a
> deterrent to acceptance into the Linux kernel.  I also think that there
> could be arguments about security.  Sending the event is one thing,
> telling which pid (and thus what user, etc.) caused the event is
> another.  For example, we can make the argument that read rights on a
> file are tantamount to the right to receive a read event.  But can we
> say that read rights are enough for a unprivileged user to know that
> root at pid 820 is writing the file?  I don't know.

It's also racy as hell.  By the time the inotify gets delivered to the
userspace process, pid 820 may be long gone.....

--==_Exmh_1119024674_7562P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCsvYicC3lWbTT17ARAre/AKCN8FOv3NP8lLqNG0Bt92HvLOrpDQCg+nNv
ZPpSZxd8bty7DtaKenem3RY=
=9IC0
-----END PGP SIGNATURE-----

--==_Exmh_1119024674_7562P--
