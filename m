Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317474AbSGXSpS>; Wed, 24 Jul 2002 14:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317483AbSGXSpS>; Wed, 24 Jul 2002 14:45:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47118 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317474AbSGXSpQ>; Wed, 24 Jul 2002 14:45:16 -0400
Date: Wed, 24 Jul 2002 11:48:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
In-Reply-To: <20020724144433.B7192@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.33.0207241142320.2117-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Jamie Lokier wrote:
> 
> Typical soft real-time code looks a bit like this pseudo-code (excuse
> the bugs :-):

Yup, looks familiar.

The thing is, we cannot change existing select semantics, and the question 
is whether what most soft-realtime wants is actually select, or whether 
people really want a "waittimeofday()".

Like your example, the only uses I've had personally (DVD playback) have
really had an empty select, so it wasn't really select itself that was 
horribly important.

		Linus

