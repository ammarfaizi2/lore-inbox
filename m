Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBOQ5N>; Thu, 15 Feb 2001 11:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129111AbRBOQ5C>; Thu, 15 Feb 2001 11:57:02 -0500
Received: from ns.suse.de ([213.95.15.193]:14353 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129104AbRBOQ4n>;
	Thu, 15 Feb 2001 11:56:43 -0500
To: William Stearns <wstearns@pobox.com>
Cc: Giacomo Catenazzi <cate@debian.org>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNONCE] Kernel Autoconfiguration utility v.0.9.1.2
In-Reply-To: <Pine.LNX.4.30.0102151115170.31520-100000@sparrow.websense.net>
X-Yow: I love ROCK 'N ROLL!  I memorized the all WORDS to ``WIPE-OUT'' in 1965!!
From: Andreas Schwab <schwab@suse.de>
Date: 15 Feb 2001 17:56:39 +0100
In-Reply-To: <Pine.LNX.4.30.0102151115170.31520-100000@sparrow.websense.net>
Message-ID: <jeelwzhol4.fsf@hawking.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.98
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Stearns <wstearns@pobox.com> writes:

|> Good day, Giacomo,
|> 
|> On Thu, 15 Feb 2001, Giacomo Catenazzi wrote:
|> 
|> > How to use: (now, testing phase)
|> >   unpack the files (better: in a new directory)
|> >   > bash autoconfigure.sh | less
|> >   check the output.
|> >   no super user privileges required!
|> 
|> 	Nice work - that's a neat way to do it.
|> 	One detail; you appear to assume that bash2 is being used.  If
|> bash1 is /bin/bash, one gets syntax errors.  The following patch allows
|> the script to run under bash1 and bash2, with no noticeable problems.
|> 
|> --- autoconfigure.sh-0.9.1.2.orig	Wed Feb 14 15:37:30 2001
|> +++ autoconfigure.sh	Thu Feb 15 10:59:45 2001
|> @@ -109,7 +109,7 @@
|>  }
|>  function found () {
|>      local conf=CONFIG_$1
|> -    if [ "${!conf}" !=  "y" ]; then
|> +    if [ "${conf}" !=  "y" ]; then
|>  	define $1 y
|>      else
|>  	debug "$1=y"

This is plain wrong.  ${!conf} and ${conf} are completely different
things.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
