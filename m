Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUJLNMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUJLNMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 09:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUJLNMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 09:12:49 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:61071 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261426AbUJLNLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 09:11:50 -0400
Date: Tue, 12 Oct 2004 15:11:38 +0200
From: Jan Hudec <bulb@ucw.cz>
To: aq <aquynh@gmail.com>
Cc: suthambhara nagaraj <suthambhara@gmail.com>,
       "Dhiman, Gaurav" <gaurav.dhiman@ca.com>,
       main kernel <linux-kernel@vger.kernel.org>,
       kernel <kernelnewbies@nl.linux.org>
Subject: Re: Kernel stack
Message-ID: <20041012131138.GU703@vagabond>
References: <577528CFDFEFA643B3324B88812B57FE3055B9@inhyms21.ca.com> <46561a790410112351942e735@mail.gmail.com> <20041012094104.GM703@vagabond> <9cde8bff04101203052a711063@mail.gmail.com> <20041012102731.GQ703@vagabond> <9cde8bff04101205302834206@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UC+RhZhEc8lcmajv"
Content-Disposition: inline
In-Reply-To: <9cde8bff04101205302834206@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UC+RhZhEc8lcmajv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 12, 2004 at 21:30:54 +0900, aq wrote:
> > > >From what you all discuss, I can say: kernel memory is devided into 2
> > > part, and the upper part are shared between processes. The below part
> > > (the kernel stack, or 8K traditionally) is specifict for each process.
> > >
> > > Is that right?
> >=20
> > No, it's not. There is just one kernel memory. In it each process has
> > it's own task_struct + kernel stack (by default 8K). There is no special
> > address mapping for these, nor are they allocated from a special area.
> >=20
> > When a context of some process is entered, esp is pointed to the top of
> > it's stack. That's exactly all it takes to exchange stacks.
>=20
> OK, lets say there are 20 processes running in the system. Then the
> kernel must allocate 20 * 8K =3D 160K just for the stacks of these
> processes. All of these 160K always occupy the kernel (kernel memory
> is never swapped out). When a process actives, ESP would switch to
> point to the corresponding stack (of that process).

This is correct.

> The remainding memory of kernel therefore is equally accessible to all
> the processes.

This is not. There is nothing like "remaining memory". **ALL* kernel
memory is equally accessible to all the processes.

There is noting special about the stacks and task-structs. They are
normal 8K structures somewhere in kernel memory.

> Is that correct ?

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--UC+RhZhEc8lcmajv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBa9gKRel1vVwhjGURAmvwAKCbrLePN57H80AKJgilXjIncewwwQCbBlqk
QaTaf5a33PFcyS18+Zqs3rY=
=gZGf
-----END PGP SIGNATURE-----

--UC+RhZhEc8lcmajv--
