Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130493AbRC0H6O>; Tue, 27 Mar 2001 02:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130685AbRC0H6F>; Tue, 27 Mar 2001 02:58:05 -0500
Received: from smtp.alcove.fr ([212.155.209.139]:27141 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S130493AbRC0H5s>;
	Tue, 27 Mar 2001 02:57:48 -0500
Date: Tue, 27 Mar 2001 09:57:02 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Use semaphore for producer/consumer case...
Message-ID: <20010327095702.B21635@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <000d01c0b3c7$e232ae90$5517fea9@local> <20010326165425.G15689@come.alcove-fr> <007d01c0b618$040b1780$5517fea9@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <007d01c0b618$040b1780$5517fea9@local>; from manfred@colorfullife.com on Mon, Mar 26, 2001 at 07:12:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2001 at 07:12:55PM +0200, Manfred Spraul wrote:

> > > That doesn't work, at least the i386 semaphore implementation
> doesn't
> > > support semaphore counts < 0.
> >
> > Does that mean that kernel semaphore can not be used for something
> > else than mutual exclusion ?
> >
> It's a bit better: counts >= 0 are supported, i.e. you can call up()
> before down(), and that's used in several places.

I see... it's somewhat different than the classical semaphore 
implementation, but usable anyway.

> The for loop that Nigel proposed should solve your problem. Multiple
> up's are handled correctly.

Now I understand his suggestion. Thanks to both of you.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|------------- Ingénieur Informatique Libre --------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|----------- Alcôve, l'informatique est libre ------------|
