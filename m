Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWA0HHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWA0HHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 02:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWA0HHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 02:07:10 -0500
Received: from h80ad2572.async.vt.edu ([128.173.37.114]:40873 "EHLO
	h80ad2572.async.vt.edu") by vger.kernel.org with ESMTP
	id S1751423AbWA0HHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 02:07:08 -0500
Message-Id: <200601270706.k0R76RqE023900@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Howard Chu <hyc@symas.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow) 
In-Reply-To: Your message of "Thu, 26 Jan 2006 16:31:28 EST."
             <Pine.LNX.4.61.0601261621250.10049@chaos.analogic.com> 
From: Valdis.Kletnieks@vt.edu
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com> <43D7BA0F.5010907@nortel.com> <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com> <43D8E298.3020402@yahoo.com.au> <43D8E96B.3070606@symas.com> <43D8EFF7.3070203@yahoo.com.au> <43D8FC76.2050906@symas.com> <Pine.LNX.4.61.0601261231460.9298@chaos.analogic.com> <43D91C33.7050401@yahoo.com.au> <Pine.LNX.4.61.0601261405320.9584@chaos.analogic.com> <43D93B4D.20601@yahoo.com.au>
            <Pine.LNX.4.61.0601261621250.10049@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1138345586_2915P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 27 Jan 2006 02:06:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1138345586_2915P
Content-Type: text/plain; charset=us-ascii

On Thu, 26 Jan 2006 16:31:28 EST, "linux-os (Dick Johnson)" said:

> "It doesn't...." even though I can run sendmail by hand, using
> telnet port 25, over the network, and know that the "." in the
> first column is the way it knows the end-of-message after it
> receives the "DATA" command.

Right. That's how an MTA talks to another MTA.  However, your mail
needs to be properly escaped.  RFC821, section 4.5.2:

     4.5.2.  TRANSPARENCY

         Without some provision for data transparency the character
         sequence "<CRLF>.<CRLF>" ends the mail text and cannot be sent
         by the user.  In general, users are not aware of such
         "forbidden" sequences.  To allow all user composed text to be
         transmitted transparently the following procedures are used.

            1. Before sending a line of mail text the sender-SMTP checks
            the first character of the line.  If it is a period, one
            additional period is inserted at the beginning of the line.

            2. When a line of mail text is received by the receiver-SMTP
            it checks the line.  If the line is composed of a single
            period it is the end of mail.  If the first character is a
            period and there are other characters on the line, the first
            character is deleted.

In other words, the on-the-wire protocol is specifically designed so that
you *cant* accidentally lose the rest of the message by sending a bare '.'.
The fact that some programs implement it when talking to the user is
merely a convenience hack on the program's part.

--==_Exmh_1138345586_2915P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQFD2cZycC3lWbTT17ARAkV7AKD2P/7ZiMkox+OYvNpDyIY3JPeDWACWIpQG
Ociv9RkkAovDq61WOuvybw==
=qrNf
-----END PGP SIGNATURE-----

--==_Exmh_1138345586_2915P--
