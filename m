Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291340AbSBMEL3>; Tue, 12 Feb 2002 23:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291343AbSBMELU>; Tue, 12 Feb 2002 23:11:20 -0500
Received: from sphere.open-net.org ([64.53.98.77]:21897 "HELO pbx.open-net.org")
	by vger.kernel.org with SMTP id <S291340AbSBMELP>;
	Tue, 12 Feb 2002 23:11:15 -0500
Date: Tue, 12 Feb 2002 23:11:10 -0500
From: Robert Jameson <rj@open-net.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols ipt_owner.o with 2.4.18-pre9 with mjc patch
Message-Id: <20020212231110.1338a0bd.rj@open-net.org>
In-Reply-To: <20020213032402.GC3588@holomorphy.com>
In-Reply-To: <20020212214016.7fa188c3.rj@open-net.org>
	<20020213032402.GC3588@holomorphy.com>
X-Mailer: Sylpheed version 0.7.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.93ae.HLJc'/?7s"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.93ae.HLJc'/?7s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

nope, after doing that i get the following.

fork.c:39: parse error before
`this_object_must_be_defined_as_export_objs_in_the_Makefile' fork.c:39:
warning: type defaults to `int' in declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile' fork.c:39:
warning: data definition has no type or storage class fork.c:40: parse
error before `this_object_must_be_defined_as_export_objs_in_the_Makefile'
fork.c:40: warning: type defaults to `int' in declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile' fork.c:40:
warning: data definition has no type or storage class fork.c:41: parse
error before `this_object_must_be_defined_as_export_objs_in_the_Makefile'
fork.c:41: warning: type defaults to `int' in declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile'



On Tue, 12 Feb 2002 19:24:02 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> On Tue, Feb 12, 2002 at 09:40:16PM -0500, Robert Jameson wrote:
> > Is there a fix for the unresolved symbols with ipt_owner.o with
> > 2.4.18-pre9 + mjc's patch, i don't know if this is 2.4.18-pre9
> > specific or if its a mjc error, either way, heres the error,
> 
> Does this help?
> 
> --- linux-virgin/kernel/fork.c  Tue Jan 29 18:28:26 2002
> +++ linux-wli/kernel/fork.c Tue Jan 29 22:42:27 2002
> @@ -36,6 +36,9 @@
>  unsigned long pidhash_size;
>  unsigned long pidhash_bits;
>  list_t *pidhash;
> +EXPORT_SYMBOL(pidhash);
> +EXPORT_SYMBOL(pidhash_bits);
> +EXPORT_SYMBOL(pidhash_size);
>  
>  rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;  /*
>  outer */
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Robert Jameson                  http://rj.open-net.org
C2 Village at Wexford Hwy 278,  Tel: +1 (843) 757 9428
Hilton Head Isl, SC             Cel: +1 (843) 298 0957 
US, 29928.                      mailto:rj@open-net.org


--=.93ae.HLJc'/?7s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8aedhyWZRCCLwK/cRArofAJ9vUiCSN6zJ78j6S/MGAEckFGBMcwCdEQO9
20BK4rYfVikQsAVbYDOJSGM=
=QLMn
-----END PGP SIGNATURE-----

--=.93ae.HLJc'/?7s--

