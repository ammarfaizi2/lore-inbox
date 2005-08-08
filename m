Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVHHPkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVHHPkP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbVHHPkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:40:15 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:31826 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750941AbVHHPkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:40:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=4FqtpCZ7vvsyAKEt50CsKDRBQ/04iwZDRW8UcJxenUB9AHxOkO7u3w0nxAgi55/BDZnvl8XDpQZeVSY8XNiVKVkPGtSxbccGB9wmvdYBxatdylBviUiWyRdFtMeRmbkRmnEHpE7nBCVXCBMGM4as5yxezDIvoClnRNNG5HlisBo=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Alexander Nyberg <alexn@telia.com>
Subject: Re: [PATCH] CHECK_IRQ_PER_CPU() to avoid dead code in __do_IRQ()
Date: Mon, 8 Aug 2005 17:36:10 +0200
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <200508081250.05673.annabellesgarden@yahoo.de> <20050808111936.GA1393@localhost.localdomain>
In-Reply-To: <20050808111936.GA1393@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508081736.10690.annabellesgarden@yahoo.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 8. August 2005 13:19 schrieb Alexander Nyberg:
> 
> There are many places where one could replace run-time tests with 
> #ifdef's but it makes reading more difficult (and in longer terms
> maintainence). Have you benchmarked any workload that benefits 
> from this?

Performance gain is small, but measurable: 0,02%
Tested on an Atlon64 running at 1000MHz.
I took this value from 9 runs (each with/without the patch) of 
	$ time lame x.wav
where each took about 1 minute.
3000 Interrupts/s were generated at the time by running
	$ jackd -R -dalsa -p64 -n2

0,02% really isn't that much....but Athlon64 is better than P4
with branch predictions, I think.

Erm... ok, I won't insist on having this patch applied ;-) 

   Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
