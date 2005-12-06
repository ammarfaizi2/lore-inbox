Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVLFL2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVLFL2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 06:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVLFL2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 06:28:42 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:19693 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932106AbVLFL2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 06:28:41 -0500
Date: Tue, 6 Dec 2005 12:29:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Engraf <engraf.david@netcom-sicherheitstechnik.de>
Cc: "'Arjan van de Ven'" <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: [PATCH] Win32 equivalent to GetTickCount systemcall (i386)
Message-ID: <20051206112900.GA29790@elte.hu>
References: <1133865880.2858.42.camel@laptopd505.fenrus.org> <000001c5fa57$797051b0$0a016696@EW10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c5fa57$797051b0$0a016696@EW10>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Engraf <engraf.david@netcom-sicherheitstechnik.de> wrote:

> > (and.. wait.. isn't that called gettimeofday() )
>
> Not really gettimeofday is based on the date and time, but what if the 
> user changes the date, the counter would also change.

see 'man clock_gettime', and CLOCK_MONOTONIC:

       CLOCK_MONOTONIC
              Clock that cannot be set and  represents  monotonic  time  since
              some unspecified starting point.

and it has microsecond resolution.

	Ingo
