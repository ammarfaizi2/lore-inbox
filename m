Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281422AbRKUOZg>; Wed, 21 Nov 2001 09:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281395AbRKUOZ1>; Wed, 21 Nov 2001 09:25:27 -0500
Received: from ns.suse.de ([213.95.15.193]:45836 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281255AbRKUOZP> convert rfc822-to-8bit;
	Wed, 21 Nov 2001 09:25:15 -0500
To: Vincent Sweeney <v.sweeney@dexterus.com>
Cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
In-Reply-To: <01112112401703.01961@nemo> <3BFB9FAE.DB9B6003@dexterus.com>
X-Yow: You mean you don't want to watch WRESTLING from ATLANTA?
From: Andreas Schwab <schwab@suse.de>
Date: 21 Nov 2001 15:25:02 +0100
In-Reply-To: <3BFB9FAE.DB9B6003@dexterus.com> (Vincent Sweeney's message of "Wed, 21 Nov 2001 12:35:58 +0000")
Message-ID: <jeu1vo9p6p.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1.30
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Sweeney <v.sweeney@dexterus.com> writes:

|> vda wrote:
|> > ------------------------------------------------------------------
|> > Undefined behavior by C std: inc/dec may happen before dereference.
|> > Probably GCC is doing inc after right side eval, but standards say nothing
|> > about it AFAIK. Move ++ out of the statement to be safe:
|> >     *a++ = byte_rev[*a]; => *a = byte_rev[*a]; a++;
|> 
|> C std says *always* evaluate from right to left for = operators, so this
|> will always make perfect sense.

No.  It is undefined which of the operator's arguments is evaluated first,
unless it is defined otherwise (only for ||, && and comma).

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
