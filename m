Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282998AbRLCIvy>; Mon, 3 Dec 2001 03:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282999AbRLCItF>; Mon, 3 Dec 2001 03:49:05 -0500
Received: from [213.96.124.18] ([213.96.124.18]:30448 "HELO dardhal")
	by vger.kernel.org with SMTP id <S284448AbRLCAAK>;
	Sun, 2 Dec 2001 19:00:10 -0500
Date: Mon, 3 Dec 2001 01:00:02 +0100
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: VM Problem : persistent swap cache
Message-ID: <20011203010002.A26016@dardhal.mired.net>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011202180801.A19628@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011202180801.A19628@wanadoo.fr>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 02 December 2001, at 18:08:02 +0100,
Edouard Gomez wrote:

> Hi,
> [...]
> As you can see, there's 20Mo of swap though lot of free RAM is available.
> The strange thing is that this 20Mo keeps growing with the time and are
> never freed.
> 
Linux's VM doesn't try to free used swap space, even there is plenty os
physical RAM available. If there are pages on swap, that is because at
some point in time those pages where considered "not used", and were
written to disk. If those pages are never reused, they stay where they
currently are, because it is the most interesting thing to do performace
wise. Trying to keep swap=0 could cause some ping-pong effect under some
workloads, with heavy access to disk, that are too slow to be accesed
more than strictly necessary.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

