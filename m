Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272142AbTHIAbB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272148AbTHIAbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:31:01 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:5084
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272142AbTHIAa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:30:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Voluspa <lista1@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O14int
Date: Sat, 9 Aug 2003 10:36:17 +1000
User-Agent: KMail/1.5.3
References: <20030808220821.61cb7174.lista1@telia.com>
In-Reply-To: <20030808220821.61cb7174.lista1@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308091036.18208.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003 06:08, Voluspa wrote:
> On 2003-08-08 15:49:25 Con Kolivas wrote:
> > More duck tape interactivity tweaks
>
> Do you have a premonition... Game-test goes down in flames. Volatile to
> the extent where I can't catch head or tail. It can behave like in
> A3-O12.2 or as an unpatched 2.6.0-test2. Trigger badness by switching to
> a text console. 

Ah. There's the answer. You've totally changed the behaviour of the 
application in question by moving to the text console. No longer is it the 
sizable cpu hog that it is when it's in the foreground on X, so you've 
totally changed it's behaviour and how it is treated.

> Sometimes it recovers, sometimes not. Sometimes fast, 
> sometimes slowly (when it does recover).

Depends on whether the scheduler has decided firmly "you're interactive or 
not". 

Your question of course is can this be changed? Well of course everything 
_can_ be... It may be simple tuning. In the meantime the answer is don't 
switch to the text console. (Doc it hurts when I do this... Well don't do 
that). Might be useful for you to see how long it has run when it recovers, 
and how long when it no longer recovers.

> I'll withdraw under my rock now. Won't come forth until everything
> smells of roses. Getting stressed by being a bringer of bad news only.
> Please speak up, all you other testers. Divide the burden. Even out the
> scores.

Wine, women and song^H^H^H games and scheduling are not a good mix. It's not 
your fault. Please do not hold back any reports.

Con

