Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSFUJjz>; Fri, 21 Jun 2002 05:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSFUJjy>; Fri, 21 Jun 2002 05:39:54 -0400
Received: from ns.suse.de ([213.95.15.193]:59144 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316530AbSFUJjx>;
	Fri, 21 Jun 2002 05:39:53 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] khttpd and make_times_h
References: <Pine.GSO.4.21.0206211048100.7190-100000@vervain.sonytel.be>
X-Yow: Hmmm..  A hash-singer and a cross-eyed guy were SLEEPING on a
 deserted
 island, when...
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 21 Jun 2002 11:39:54 +0200
In-Reply-To: <Pine.GSO.4.21.0206211048100.7190-100000@vervain.sonytel.be> (Geert
 Uytterhoeven's message of "Fri, 21 Jun 2002 11:14:13 +0200 (MEST)")
Message-ID: <jek7otgec5.fsf@sykes.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

|> khttpd doesn't build in 2.5.24 because the shell can't find make_times_h.
|> 
|> --- linux-2.5.24/net/khttpd/Makefile	Fri Jun 21 09:34:54 2002
|> +++ linux-m68k-2.5.24/net/khttpd/Makefile	Fri Jun 21 10:50:15 2002
|> @@ -19,4 +19,4 @@
|>  # Generated files
|>  
|>  $(obj)/times.h: $(obj)/make_times_h
|> -	$< >$@
|> +	$(obj)/make_times_h >$@

You can also use $(<D)/$(<F) or $(dir $<)$(notdir $<).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
