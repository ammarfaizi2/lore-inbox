Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbREQTsu>; Thu, 17 May 2001 15:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261866AbREQTsk>; Thu, 17 May 2001 15:48:40 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55021 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261868AbREQTs1>;
	Thu, 17 May 2001 15:48:27 -0400
Message-ID: <3B042B07.25F65905@mandrakesoft.com>
Date: Thu, 17 May 2001 15:48:23 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rich Baum <richbaum@acm.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.4.5pre3 warning fixes
In-Reply-To: <7C4D2505D3F@coral.indstate.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rich Baum wrote:
> @@ -1543,6 +1543,7 @@
>           EXCEPTION(EX_INTERNAL | 0x116);
>           return;
>  #endif /* PARANOID */
> +         ;
>         }
>      }
>    else if ( (st0_tag == TAG_Valid) || (st0_tag == TW_Denormal) )
> @@ -437,7 +437,7 @@
>         /* XXX shouldn't we *start* by deregistering the device? */
>         atm_dev_deregister(fore200e->atm_dev);
> 
> -    case FORE200E_STATE_BLANK:
> +    case FORE200E_STATE_BLANK:;
>         /* nothing to do for that state */
>      }
>  }
> @@ -556,7 +556,7 @@
>                 }
>                 break;
>  #endif
> -       default:
> +       default:;
>                 /* nothing */
>         }
> 

IMHO the ":;" form is really easy to miss or mistake.

Can't you put a "break;" after the "nothing" comment instead?  The
compiled code is not bigger, and while the source gets a bit bigger, I
think the extra "break;" helps maintenance in the long term.

	Jeff


-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
