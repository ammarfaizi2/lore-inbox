Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVCIBeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVCIBeu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 20:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVCIBeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 20:34:50 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:34469 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261385AbVCIBep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:34:45 -0500
Date: Wed, 9 Mar 2005 02:37:33 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Message-ID: <20050309013733.GA21386@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Gerd Knorr <kraxel@bytesex.org>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	linux-dvb-maintainer@linuxtv.org
References: <20050308105726.GA30986@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308105726.GA30986@bytesex>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 217.231.61.171
Subject: Re: [linux-dvb] [patch] dvb: add pll lib
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(linux-dvb list removed from Cc: because it is subscribers only)

On Tue, Mar 08, 2005 at 11:57:26AM +0100, Gerd Knorr wrote:
> This adds some helper code to handle tuning for dvb cards,
> with a struct describing the pll and a function calculating
> the command sequence needed to program it.
> 
> This one was discussed + accepted on the linuxtv list and
> also is in the linuxtv cvs.  As the the cx88 driver update
> I want finally get out of the door depends on this one I'll
> go submit it myself instead of waiting for the dvb guys doing
> it.

Michael Hunold is somewhat busy with his new job at Toshiba, so I want
to takeover patch submission for now. However, one thing that makes it
difficult to create kernel patches from linuxtv.org CVS is that there
are a large number of whitespace differences between the kernel tree and
CVS. There's also some corrupted indentation in the kernel, e.g.
drivers/media/dvb/frontends/tda1004x.c:tda1004x_sleep().
I wanted to get this issue out of the way before I start
to submit other patches from linuxtv.org CVS.

I merged some whitespace cleanups from the kernel into CVS,
and created a patch to clean up whitespace in the kernel,
removing lots of whitespace at end-of-line in the go.
The problem with this patch is that it is huge (600K) :-(.
I was crazy enough to mail it to Linus anyway on Sunday,
and it looks like it got dropped on the floor :-((

It would be nice if I could get some advice how to submit this kind of
cleanup (i.e. if I should split it up in tiny fragments), or if I
should ignore the issue for now and concentrate on functional
improvements.

The DVB related patches submitted by Gerd are non-controversial
and should be applied.

Johannes
