Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLOR1z>; Fri, 15 Dec 2000 12:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLOR1q>; Fri, 15 Dec 2000 12:27:46 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:36139 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129183AbQLOR1a>; Fri, 15 Dec 2000 12:27:30 -0500
Date: Fri, 15 Dec 2000 17:56:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mike Black <mblack@csihq.com>
Cc: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
Message-ID: <20001215175632.A17781@inspiron.random>
In-Reply-To: <03bc01c066b4$3252d690$e1de11cc@csihq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03bc01c066b4$3252d690$e1de11cc@csihq.com>; from mblack@csihq.com on Fri, Dec 15, 2000 at 11:29:28AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 11:29:28AM -0500, Mike Black wrote:
> include/linux/signal.h
> 
> There's a couple like this -- isn't this case statement upside down???
> 
> extern inline void siginitset(sigset_t *set, unsigned long mask)
> {
>         set->sig[0] = mask;
>         switch (_NSIG_WORDS) {
>         default:
>                 memset(&set->sig[1], 0, sizeof(long)*(_NSIG_WORDS-1));
>                 break;
>         case 2: set->sig[1] = 0;
>         case 1:
>         }
> }
> 
> gcc is complaining:
> /usr/src/linux/include/linux/signal.h:193: warning: deprecated use of label
> at end of compound statement

You're using a too recent gcc (I got flooded too indeed). I disagree with such
a warning, current code makes perfect sense.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
