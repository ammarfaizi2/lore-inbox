Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSESVsf>; Sun, 19 May 2002 17:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSESVse>; Sun, 19 May 2002 17:48:34 -0400
Received: from panda.sul.com.br ([200.219.150.4]:12554 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id <S315265AbSESVsd>;
	Sun, 19 May 2002 17:48:33 -0400
Date: Sun, 19 May 2002 09:48:18 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
Message-ID: <20020519124818.GA5481@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <E179IA6-0002eQ-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 19, 2002 at 02:18:53PM +1000, Rusty Russell escreveu:
> The following uses seem to be incorrect: copy_from_user and
> copy_to_user return the number of bytes NOT copied on failure, not
> -EFAULT.
> 
> You can CC: fixups to trivial at rustcorp.com.au.
> 
> (I didn't look for cases where the Torvalds/McVoy philosophy says we
> should be returning a partial result on EFAULT: that's more complex).
> 
> Thanks,
> Rusty.
> ================
> Some cases are endemic: whole subsystems or drivers where the author
> obviously thought copy_from_user follows the kernel conventions:

> sound/pci/*.c

Heads up: I'm fixing now the sound/pci ones...

- Arnaldo
