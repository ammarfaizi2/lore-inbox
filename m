Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293328AbSBQT3B>; Sun, 17 Feb 2002 14:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293333AbSBQT2w>; Sun, 17 Feb 2002 14:28:52 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:44559 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S293328AbSBQT2e>; Sun, 17 Feb 2002 14:28:34 -0500
Date: Sun, 17 Feb 2002 20:28:27 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch][looking for maintainers] jiffies compare fixups 
In-Reply-To: <200202110735.g1B7Z7LJ002187@tigger.cs.uni-dortmund.de>
Message-ID: <Pine.LNX.4.33.0202172017220.3075-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002, Horst von Brand wrote:

> Tim Schmielau <tim@physik3.uni-rostock.de> said:
> > At the end of December, I made a patch to fix comparisons of the jiffies
> > counter that would break at jiffies wraparound.
> 
> I think you should just forward the remaining bits to Marcelo directly.
> 

Yes, I think I'll do so for 2.4.19pre.

[...]
> > -	if (led_active && jiffies > led_next_time) {
> > +	if (led_active && jiffies > time_after(jiffies, led_next_time)) {
[...]
> This hunk is surely wrong.

Thank you for spotting this. Obviously there are times at night when it is 
even too late for simple search&replace like changes.

Also thanks for your comments on the busy-waiting loops. I stumbled 
across them, too, but decided to first do the uncontroversial time_before/
time_after fix. I think I'll do another run on this low-latency
(well, less-horrendous latency:-) stuff later.

Tim


