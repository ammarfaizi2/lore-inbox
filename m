Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261477AbTCMA61>; Wed, 12 Mar 2003 19:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbTCMA61>; Wed, 12 Mar 2003 19:58:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3847 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261477AbTCMA60>; Wed, 12 Mar 2003 19:58:26 -0500
Date: Wed, 12 Mar 2003 17:07:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Szakacsits Szabolcs <szaka@sienet.hu>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <Pine.LNX.4.30.0303122320400.18833-100000@divine.city.tvnet.hu>
Message-ID: <Pine.LNX.4.44.0303121706030.16238-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Szakacsits Szabolcs wrote:
> > I'm not adding uncertain instruction decoding to the kernel.
> 
> From some point of you I understand. But it's not uncertain. The
> correct one is 100% included.

Sorry, there is _no_ way you can do it correctly.

The preceding bytes may not even be code - they can be constant data in 
the code segment. Trying to decode them as code just generates garbage in 
those circumstances.

		Linus

