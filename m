Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317939AbSGPTHQ>; Tue, 16 Jul 2002 15:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317944AbSGPTHQ>; Tue, 16 Jul 2002 15:07:16 -0400
Received: from dsl-65-188-226-101.telocity.com ([65.188.226.101]:44682 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id <S317939AbSGPTHP>; Tue, 16 Jul 2002 15:07:15 -0400
Date: Tue, 16 Jul 2002 15:10:17 -0400
To: "Filip Sneppe (Yucom)" <filip.sneppe@yucom.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to improve the throughput of linux network
Message-ID: <20020716191017.GA26500@reflexsecurity.com>
References: <200207160915391.SM00792@zhengcb> <slrnaj8b8s.p4m.lunz@stoli.localnet> <1026838787.401.15.camel@xbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026838787.401.15.camel@xbox>
User-Agent: Mutt/1.3.28i
From: Jason Lunz <lunz@reflexsecurity.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at  6:59PM +0200, Filip Sneppe (Yucom) wrote:
> Hey, that's funny. I downloaded NAPI patches from:
> ftp://robur.slu.se/pub/Linux/net-development/NAPI/

Yes, that's where the NAPI stuff originates. The core patch from that
site is what made it into 2.5, and I backported it to 2.4 from there.
There are no substantial differences between the three.

> How different are those patches from yours ? Did you just make
> sure they all applied cleanly ?

While the core is mostly a matter of changing patch offsets, the driver
patches are still a moving target. There are two different flavors of
the e1000 NAPI patch, for example. The most recent tulip patch from the
above FTP site is missing tulip_misc.c, so it must be replaced with a
version from another patch.  That file really is only code to report
stats in /proc, though. There's yet another napified tulip driver that
jamal posted a link to; I have yet to investigate that one.

But to answer your question, yes. I just found the most recent versions
of various napi efforts and made them apply to a recent 2.4 kernel so
people can easily try out the new net core.

Jason
