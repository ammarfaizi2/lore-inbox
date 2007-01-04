Return-Path: <linux-kernel-owner+w=401wt.eu-S965115AbXADWYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbXADWYF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbXADWYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:24:04 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:52203 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965115AbXADWYB (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:24:01 -0500
Message-Id: <200701042223.l04MNZB2002002@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 8/8] user ns: implement user ns unshare
In-Reply-To: Your message of "Thu, 04 Jan 2007 19:07:00 GMT."
             <20070104190700.GB17863@slug>
From: Valdis.Kletnieks@vt.edu
References: <20070104180635.GA11377@sergelap.austin.ibm.com> <20070104181310.GI11377@sergelap.austin.ibm.com>
            <20070104190700.GB17863@slug>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1167949415_12762P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 04 Jan 2007 17:23:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1167949415_12762P
Content-Type: text/plain; charset=us-ascii

On Thu, 04 Jan 2007 19:07:00 GMT, Frederik Deweerdt said:
> On Thu, Jan 04, 2007 at 12:13:10PM -0600, Serge E. Hallyn wrote:
> > From: Serge E. Hallyn <serue@us.ibm.com>
> > Subject: [PATCH -mm 8/8] user ns: implement user ns unshare
> > 
> > Implement CLONE_NEWUSER flag useable at clone/unshare.
> > 
> > Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> > ---
>   
> >  int copy_user_ns(int flags, struct task_struct *tsk)
> >  {
> > -	struct user_namespace *old_ns = tsk->nsproxy->user_ns;
> > +	struct user_namespace *new_ns, *old_ns = tsk->nsproxy->user_ns;
> >  	int err = 0;
>         ^^^^^^^^^^^^
> The "= 0" is superfluous here.

Umm?  bss gets cleared automagically, but when did we start auto-zeroing
the stack?

--==_Exmh_1167949415_12762P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFnX5ncC3lWbTT17ARAgncAJsG2XdkbvylxKhLHmCTlUid530+9ACeLCXp
MOO+F/CrnLuvBKw7TxSB7rA=
=o66Z
-----END PGP SIGNATURE-----

--==_Exmh_1167949415_12762P--
