Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267103AbTBDDDy>; Mon, 3 Feb 2003 22:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267104AbTBDDDy>; Mon, 3 Feb 2003 22:03:54 -0500
Received: from mail.infonet-europe.net ([195.206.66.146]:9637 "HELO
	mailgate.eqip.net") by vger.kernel.org with SMTP id <S267103AbTBDDDx>;
	Mon, 3 Feb 2003 22:03:53 -0500
Path: Home.Lunix!not-for-mail
Subject: Re: two x86_64 fixes for 2.4.21-pre3
Date: Tue, 4 Feb 2003 03:13:22 +0000 (UTC)
Organization: lunix confusion services
References: <15921.37163.139583.74988@harpo.it.uu.se>
NNTP-Posting-Host: kali.eth
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 1044328402 13177 10.253.0.3 (4 Feb 2003
    03:13:22 GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Tue, 4 Feb 2003 03:13:22 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:212364
X-Mailer: Perl5 Mail::Internet v1.51
Message-Id: <b1nb4i$crp$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <15921.37163.139583.74988@harpo.it.uu.se>,
	Mikael Pettersson <mikpe@csd.uu.se> writes:
>  #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
>  
> +#define __save_and_cli(x)	do { __save_flags(x); __cli(); } while(0);
> +#define __save_and_sti(x)	do { __save_flags(x); __sti(); } while(0);
> +

The extra ; after the while(0) look wrong.

>  #define restore_flags(x) __global_restore_flags(x)
> +#define save_and_cli(x) do { save_flags(x); cli(); } while(0);
> +#define save_and_sti(x) do { save_flags(x); sti(); } while(0);

Same here
