Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316616AbSE3NTr>; Thu, 30 May 2002 09:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316617AbSE3NTq>; Thu, 30 May 2002 09:19:46 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:51443 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316616AbSE3NTp>; Thu, 30 May 2002 09:19:45 -0400
Subject: Re: [PATCH]: kernel-api.* compilation fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <m21ybtj02l.fsf@demo.mitica>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 May 2002 15:23:22 +0100
Message-Id: <1022768602.4124.370.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-30 at 13:24, Juan Quintela wrote:
>         new dockbook utils are more picky about malformed SGML, I need
>         that patch to get kernel-api.* to compile, notice that this
>         really looks as the original intend.

Yep.. The functions got exported in the 2.4.19pre9 patch which changed
what was needed

Marcelo I agree with this change

> 
> diff -urN --exclude-from=/home/mitica/quintela/config/misc/dontdiff linux/Documentation/DocBook/kernel-api.tmpl linux-new/Documentation/DocBook/kernel-api.tmpl
> --- linux/Documentation/DocBook/kernel-api.tmpl	2002-05-30 13:14:09.000000000 +0200
> +++ linux-new/Documentation/DocBook/kernel-api.tmpl	2002-05-30 13:01:12.000000000 +0200
> @@ -272,7 +272,7 @@
>  !Edrivers/video/fbcmap.c
>       </sect1>
>       <sect1><title>Frame Buffer Generic Functions</title>
> -!Idrivers/video/fbgen.c
> +!Edrivers/video/fbgen.c
>       </sect1>
>       <sect1><title>Frame Buffer Video Mode Database</title>
>  !Idrivers/video/modedb.c
> 
> 
> -- 
> In theory, practice and theory are the same, but in practice they 
> are different -- Larry McVoy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

