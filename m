Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318946AbSICWza>; Tue, 3 Sep 2002 18:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318969AbSICWza>; Tue, 3 Sep 2002 18:55:30 -0400
Received: from AMontpellier-205-1-4-20.abo.wanadoo.fr ([217.128.205.20]:26796
	"EHLO awak") by vger.kernel.org with ESMTP id <S318946AbSICWz3> convert rfc822-to-8bit;
	Tue, 3 Sep 2002 18:55:29 -0400
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
From: Xavier Bestel <xavier.bestel@free.fr>
To: ptb@it.uc3m.es
Cc: Anton Altaparmakov <aia21@cantab.net>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200209032242.g83MglG21464@oboe.it.uc3m.es>
References: <200209032242.g83MglG21464@oboe.it.uc3m.es>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Sep 2002 00:52:58 +0200
Message-Id: <1031093579.1073.6.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 04/09/2002 à 00:42, Peter T. Breuer a écrit :

> Let's maintain a single bit in the superblock that says whether  any
> directory structure or whatever else we're worried about has been
> altered (ecch, well, it has to be a timestamp, never mind ..). Before
> every read we check this "bit" ondisk. If it's not set, we happily dive
> for our data where we expect to find it. Otherwise we go through the
> rigmarole you describe.

Won't work. You would need an atomic read-and-write operation for that
(read previous timestamp and write a special timestamp meaning
"currently writing this block"), and you don't have that.

	Xav


