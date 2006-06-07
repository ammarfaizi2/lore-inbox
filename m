Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWFGRd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWFGRd7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWFGRd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:33:59 -0400
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:56241 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932361AbWFGRd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:33:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ZkZ7bKY4DIpfastOJAPsf+bzVdu/mrLQ1Tdm6raECSzH+vmUMTnpXXV7Nq0Vi6+3AJmbFecPuZT13Jm9FOw4C9CLkC52NjjdLQ8wOg7OqIstI2HJXccxnSMHQTJehcAB2V4NwpNDDH+ST7K+ukMd7kg/4ogGYiII33nAP5+nUOY=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 2/8] UML - Define jmpbuf access constants
Date: Wed, 7 Jun 2006 19:33:28 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200602070223.k172NpJa009654@ccure.user-mode-linux.org> <200606042020.00120.blaisorblade@yahoo.it> <20060605154017.GA24405@ccure.user-mode-linux.org>
In-Reply-To: <20060605154017.GA24405@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606071933.28456.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 June 2006 17:40, Jeff Dike wrote:
> On Sun, Jun 04, 2006 at 08:19:59PM +0200, Blaisorblade wrote:
> > What about #ifdef'ing out the offending code #ifndef one of these
> > constants (they'll be defined or not altogether). As expectable, this
> > wasn't yet implemented - let's give the right priority to things.
> > (I've just met this on my SuSE, btw, which prompted me to write this
> > email).
>
> I think hpa just came to our rescue.  There's a setjmp/longjmp
> implementation in klibc.  If we pull that in and use it, we don't need
> our own copy.

Ok - but we can merge something before 2.6.17, and we should. Any of them. 
Guess which one...

Not merging hacks is sometimes ok, and guarantees better code. But we're 
exceeding in this :-)
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
