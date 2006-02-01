Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422944AbWBAVdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422944AbWBAVdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 16:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422945AbWBAVdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 16:33:44 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:39819 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1422944AbWBAVdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 16:33:43 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Thu, 2 Feb 2006 07:30:12 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602012245.06328.nigel@suspend2.net> <84144f020602010501k23e7898at82c0f231a2da0ad4@mail.gmail.com>
In-Reply-To: <84144f020602010501k23e7898at82c0f231a2da0ad4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2604771.pHX0mUr3VH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602020730.16916.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2604771.pHX0mUr3VH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 01 February 2006 23:01, Pekka Enberg wrote:
> On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > --- /dev/null
> > +++ b/kernel/power/modules.h
> >
> > +struct module_header {
>
> [snip]
>
> > +extern int num_modules, num_writers;
>
> [snip]
>
> > +extern struct suspend_module_ops *active_writer;
>
> [snip]
>
> > +extern void prepare_console_modules(void);
> > +extern void cleanup_console_modules(void);
>
> [snip, snip]
>
> > +extern unsigned long header_storage_for_modules(void);
> > +extern unsigned long memory_for_modules(void);
> > +
> > +extern int print_module_debug_info(char *buffer, int buffer_size);
>
> Suspend prefix for the names of all of the above please? They're
> confusing with kernel/module.c now.

=46air enough. Will do.

> > +extern int suspend_register_module(struct suspend_module_ops *module);
> > +extern void suspend_unregister_module(struct suspend_module_ops
> > *module); +
> > +extern int suspend2_initialise_modules(int starting_cycle);
> > +extern void suspend2_cleanup_modules(int finishing_cycle);
> > +
> > +int suspend2_get_modules(void);
> > +void suspend2_put_modules(void);
>
> I think we can call these suspend_{get|set}_modules instead i.e.
> without the extra '2'.

I wanted to avoid confusion with similar routine names Pavel might use. For=
=20
example, he has a resume_setup and I have a resume2_setup.

> > +
> > +static inline void suspend_initialise_module_lists(void) {
> > +       INIT_LIST_HEAD(&suspend_filters);
> > +       INIT_LIST_HEAD(&suspend_writers);
> > +       INIT_LIST_HEAD(&suspend_modules);
> > +}
>
> I couldn't find a user for this. I would imagine there's only one,
> though, and this should be inlined there?

Ok.

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2604771.pHX0mUr3VH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4ShoN0y+n1M3mo0RArtfAKCN4gus7pw2o6+7BnVeggBf41wiXgCfW1Pt
5/PAZr9T2k0yGLpA4WfYoNs=
=u84y
-----END PGP SIGNATURE-----

--nextPart2604771.pHX0mUr3VH--
