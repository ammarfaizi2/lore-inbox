Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTJQBzJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 21:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTJQBzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 21:55:09 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:58289 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263171AbTJQBzG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 21:55:06 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 16 Oct 2003 18:49:06 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: jlnance@unity.ncsu.edu
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Transparent compression in the FS
In-Reply-To: <20031017013245.GA6053@ncsu.edu>
Message-ID: <Pine.LNX.4.56.0310161846300.2217@bigblue.dev.mdolabs.com>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl>
 <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random>
 <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14>
 <20031016230448.GA29279@pegasys.ws> <20031017013245.GA6053@ncsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Oct 2003 jlnance@unity.ncsu.edu wrote:

> On Thu, Oct 16, 2003 at 04:04:48PM -0700, jw schultz wrote:
> >
> > The idea of this sort of block level hashing to allow
> > sharing of identical blocks seems attractive but i wouldn't
> > trust any design that did not accept as given that there
> > would be false positives.
>
> But at the same time we rely on TCP/IP which uses a hash (checksum)
> to detect back packets.  It seems to work well in practice even
> though the hash is weak and the network corrupts a lot of packets.
>
> Lots of machines dont have ECC ram and seem to work reasonably well.
>
> It seems like these two are a lot more likely to bit you than hash
> collisions in MD5.  But Ill have to go read the paper to see what
> Im missing.

The TCP/ECC thingies are different since the probability of false
negatives is the combined probability that 1) the data is wrong 2) the
hash collides. In case of a hash-indexing algo the probability of coliding
hashes is "raw".



- Davide

