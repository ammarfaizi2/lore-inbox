Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266915AbUHITVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266915AbUHITVb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266920AbUHITTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:19:00 -0400
Received: from mout2.freenet.de ([194.97.50.155]:62927 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S266915AbUHITNF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:13:05 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [RFC] Host Virtual Serial Interface driver
Date: Mon, 9 Aug 2004 21:12:22 +0200
User-Agent: KMail/1.6.2
References: <1091827384.31867.21.camel@localhost> <20040809184859.GA20397@mars.ravnborg.org> <200408091351.49211.hollisb@us.ibm.com>
In-Reply-To: <200408091351.49211.hollisb@us.ibm.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200408092112.24187.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting Hollis Blanchard <hollisb@us.ibm.com>:
> > pr_debug is a noop if DEBUG is not defined. Make dump_hex, dump_packet
> > be a noop also and you get rid of several #ifdef in the code.
> 
> I'd like to do that, but notice that dump_hex() is called from dump_packet() 
> from hvsi_recv_response() (and I've just made hvsi_recv_control() the same). 
> Even with debug disabled, I'd like to be able to dump a whole packet if I get 
> confused...

#ifdef DEBUG
# define dump_hex_dbg(a, b)	dump_hex(a, b)
#else
# define dump_hex_dbg(a, b)	do { } while (0)
#endif /* DEBUG */

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBF8yWFGK1OIvVOP4RAv3xAJ91heLG1BQzB+rLkA7w3D+3RhRdYgCg4pMI
uTJPQXzVvJppF14S71neVnI=
=zDzy
-----END PGP SIGNATURE-----
