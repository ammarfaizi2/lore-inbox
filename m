Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270206AbTGWLni (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 07:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270210AbTGWLnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 07:43:37 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:64956 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S270206AbTGWLnD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 07:43:03 -0400
Date: Wed, 23 Jul 2003 14:57:43 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: "David S. Miller" <davem@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, a.marsman@aYniK.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre7: are security issues solved?
Message-ID: <20030723115742.GK150921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	"David S. Miller" <davem@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, a.marsman@aYniK.com,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0307212234390.3580-100000@localhost.localdomain> <E19fGMZ-0000Zm-00@gondolin.me.apana.org.au> <20030723033505.145db6b8.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030723033505.145db6b8.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 03:35:05AM -0700, you [David S. Miller] wrote:
> On Wed, 23 Jul 2003 19:56:47 +1000
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
> > Aschwin Marsman <a.marsman@aynik.com> wrote:
> > > 
> > >> CAN-2003-0461: /proc/tty/driver/serial reveals the exact character counts
> > >> for serial links. This could be used by a local attacker to infer password
> > >> lengths and inter-keystroke timings during password entry.
> > 
> > What's the problem with exposing those counters?
> 
> If I know your password is 7 characters I have a smaller
> space of passwords to search to just brute-force it.

Further, if you monitor the /proc/tty/driver/serial character counts with
small enough resolution, I guess you could learn the delays between
individual key presses when the user enters his password. This can be used
to further aid the brute force attack (delays between different key pairs
have different average delays statistically, just as different characters
have different frequencies in a given language. I think there is a paper on
this, and someone suggested an attack like this for snooping ssh
passwords.)


-- v --

v@iki.fi
