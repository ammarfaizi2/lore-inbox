Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267950AbTBYMX5>; Tue, 25 Feb 2003 07:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267951AbTBYMX5>; Tue, 25 Feb 2003 07:23:57 -0500
Received: from ns.suse.de ([213.95.15.193]:55301 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267950AbTBYMX4>;
	Tue, 25 Feb 2003 07:23:56 -0500
To: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
X-Yow: ..  I have a VISION!  It's a RANCID double-FISHWICH on an ENRICHED
 BUN!!
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 25 Feb 2003 13:34:09 +0100
In-Reply-To: <20030224222144.GA27579@wohnheim.fh-wedel.de>
 =?iso-8859-1?q?(J=F6rn?= Engel's message of "Mon, 24 Feb 2003 23:21:44
 +0100")
Message-ID: <jeadgk5yke.fsf@sykes.suse.de>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.3.50
References: <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com>
	<jeznol5plv.fsf@sykes.suse.de> <20030224215335.GA24975@gtf.org>
	<jeu1et5o4i.fsf@sykes.suse.de>
	<20030224222144.GA27579@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> writes:

|> On Mon, 24 February 2003 23:07:25 +0100, Andreas Schwab wrote:
|> > 
|> > Jeff Garzik <jgarzik@pobox.com> writes:
|> > 
|> > |> On Mon, Feb 24, 2003 at 10:35:24PM +0100, Andreas Schwab wrote:
|> > |> > Linus Torvalds <torvalds@transmeta.com> writes:
|> > |> > 
|> > |> > |> Does gcc still warn about things like
|> > |> > |> 
|> > |> > |> 	#define COUNT (sizeof(array)/sizeof(element))
|> > |> > |> 
|> > |> > |> 	int i;
|> > |> > |> 	for (i = 0; i < COUNT; i++)
|> > |> > |> 		...
|> > |> > |> 
|> > |> > |> where COUNT is obviously unsigned (because sizeof is size_t and thus 
|> > |> > |> unsigned)?
|> > |> > |> 
|> > |> > |> Gcc used to complain about things like that, which is a FUCKING DISASTER. 
|> > |> > 
|> > |> > How can you distinguish that from other occurrences of (int)<(size_t)?
|> > |> 
|> > |> The bounds are obviously constant and unsigned at compile time.
|> > 
|> > But that's not the point.  It's the runtime value of i that gets converted
|> > (to unsigned), not the compile time value of COUNT.  Thus if i ever gets
|> > negative you have a problem.
|> 
|> COUNT is constant and COUNT < INT_MAX. gcc can cast the constant bound
|> to the variable's type to fix this problem.

This is not how C works.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
