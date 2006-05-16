Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWEPP5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWEPP5a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWEPP53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:57:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:51311 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751286AbWEPP53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:57:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LbxgOjI1zpFi9/DuSZq9ZT+/9C7/BmHc92Na5xrbXBZtmCBPtf1Wi6YL5kb1bzYZ1U1qgJUVnOhUCNOzjieVxOYVZPG8Kt6BfxJvA7YB4gpGcxEoSrs6wioeCnTkxudsHkwUZjdFNVkGzMksLppYUv4aulUPrKVKFyOc2oh6WDI=
Message-ID: <4469F662.6000407@gmail.com>
Date: Wed, 17 May 2006 00:57:22 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: PATCH: Fix broken PIO with libata
References: <1147790393.2151.62.camel@localhost.localdomain> <4469F169.2050708@gmail.com> <4469F43C.3080406@pobox.com>
In-Reply-To: <4469F43C.3080406@pobox.com>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Is this agreed upon?  I tend to omit almost all unnecessary (by operator
>> precedence) parenthesis, so in new EH and all other stuff, the "a && b &
>> c" sort of lines are abundant.  If this is something that's agreed upon,
>> I can do a clean sweep over those.
> 
> 
> More parens == easier to review.  So
> 	a && b & c
> should be
> 	a && (b & c)

Understood.  Usually, my rule is something like doing the least
maximizes consistency (style-wise) thus increasing readability in the
end, but rules usually suck, don't they?  What fits the most eyes is the
best, I guess.

> to clearly delineate the separate expressions to the human eye, and also
> make it clear to the reader that the '&' is intended, and not a typo
> that should have been '&&'.
> 
> Anytime you see a long string of 'if' conditions, and the operators
> vary, add parents for readability.
> 

Yeap, will do, from now on.

-- 
tejun
