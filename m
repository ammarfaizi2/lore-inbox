Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263761AbREYPPP>; Fri, 25 May 2001 11:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263763AbREYPPF>; Fri, 25 May 2001 11:15:05 -0400
Received: from 125-CORU-X13.libre.retevision.es ([62.83.48.125]:47257 "HELO
	trasno.mitica") by vger.kernel.org with SMTP id <S263761AbREYPOw>;
	Fri, 25 May 2001 11:14:52 -0400
To: Rich Baum <richbaum@acm.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] warning fixes for 2.4.5pre5
In-Reply-To: <873E21525C8@coral.indstate.edu>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <873E21525C8@coral.indstate.edu>
Date: 25 May 2001 17:13:39 +0200
Message-ID: <m2ae41o40s.fsf@trasno.mitica>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi 

> --- linux/arch/i386/math-emu/fpu_trig.c	Fri Apr  6 12:42:47 2001
> +++ rb/arch/i386/math-emu/fpu_trig.c	Tue May 22 16:44:57 2001
> @@ -1543,6 +1543,7 @@
> 	  EXCEPTION(EX_INTERNAL | 0x116);
> 	  return;
> #endif /* PARANOID */
>+	  return;	
> 	}
>     }
>   else if ( (st0_tag == TAG_Valid) || (st0_tag == TW_Denormal) )

Will not be better to move the return out of the #endif PARANOID?
Otherwise you get 2 returns when you have defined paranoid ...

> --- linux/drivers/scsi/sym53c8xx.c	Fri Apr 27 15:59:19 2001
> +++ rb/drivers/scsi/sym53c8xx.c	Tue May 22 16:45:03 2001
> @@ -11564,6 +11564,7 @@
> 	OUTL_DSP (NCB_SCRIPT_PHYS (np, clrack));
> 	return;
> out_stuck:
>+	return;
> }
 
same
 
Later,Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
