Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264235AbUENFcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbUENFcX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 01:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUENFcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 01:32:23 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:34446 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264235AbUENFcU (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 01:32:20 -0400
Message-Id: <200405140532.i4E5WF4p006799@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Chris Wright <chrisw@osdl.org>
Cc: Andy Lutomirski <luto@myrealbox.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities, take 3 (Re: [PATCH] capabilites, take 2) 
In-Reply-To: Your message of "Thu, 13 May 2004 22:04:15 PDT."
             <20040513220415.E22989@build.pdx.osdl.net> 
From: Valdis.Kletnieks@vt.edu
References: <200405131308.40477.luto@myrealbox.com> <20040513182010.L21045@build.pdx.osdl.net> <200405131945.53723.luto@myrealbox.com>
            <20040513220415.E22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_673854761P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 14 May 2004 01:32:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_673854761P
Content-Type: text/plain; charset=us-ascii

On Thu, 13 May 2004 22:04:15 PDT, Chris Wright said:

> Well, I wonder what IRIX does?  They support capabilities and had a
> reasonable sized hand in the draft.  No point in making it impossible
> to port apps.  It's not that I'm a strong fan of Posix caps, but
> compatibility (even with a partially complete draft) with defacto
> standards is not entirely unreasonable.

The IRIX 6.5 manpage says:


    A process has three, possibly empty, sets of capabilities.  The permitted
     capability set is the maximum set of capabilities for the process.  The
     effective capability set contains those capabilities that are currently
     active for the process.  The inherited capability set contains those
     capabilities that the process may pass to the next process image across
     exec(2).

     Only capabilities in a process' effective capability set allow the
     process to perform restricted operations.  A process may use capability
     management functions to add or remove capabilities from its effective
     capability set.  However the capabilities that a process can make
     effective are limited to those that exist in its permitted capability
     set.

     Only capabilities in the process' inherited capability set can be passed
     across exec(2).

     Capabilities are also associated with files.  There may or may not be a
     capability set associated with a specific file.  If a file has no
     capability set, execution of this file through an exec(2) will leave the
     process' capability set unchanged.  If a file has a capability set,
     execution of file will affect the process' capability set in the
     following way: a file's inherited capability set further constrains the
     process inherited capabilities that are passed from one process image to
     another. The file's permitted capability set contains the capabilities
     that are unconditionally permitted to a process upon execution of that
     file.  The file's effective capabilities are the capabilities that become
     immediately active for the process upon execution of the file.

     More precisely described, the process capability assignment algorithm is:

              I-proc-new = I-proc-old & I-file
              P-proc-new = P-file | (I-proc-new & P-proc-old)
              E-proc-new = P-proc-new & E-file

     File capabilities are supported only on XFS filesystems.

Note that Irix has *3* capability vectors attached to a file....

--==_Exmh_673854761P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFApFnfcC3lWbTT17ARAtkuAKCvVXBz5+e7szf/jArOYNyAeB8UGwCg3mr/
V8UtQWFwxLqo9n+YjSeNRIo=
=OfKR
-----END PGP SIGNATURE-----

--==_Exmh_673854761P--
