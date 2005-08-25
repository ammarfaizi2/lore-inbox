Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVHYBLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVHYBLO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 21:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVHYBLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 21:11:14 -0400
Received: from main.gmane.org ([80.91.229.2]:15289 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932458AbVHYBLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 21:11:14 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Daniel Brockman <daniel@brockman.se>
Subject: Where do packets sent to 255.255.255.255 go?
Date: Thu, 25 Aug 2005 03:02:26 +0200
Message-ID: <87ek8isual.fsf@wigwam.deepwood.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-46b670d5.028-10-67766c2.cust.bredbandsbolaget.se
X-Face: :&2UWGm>e24)ip~'K@iOsA&JT3JX*v@1-#L)=dUb825\Fwg#`^N!Y*g-TqdS
 AevzjFJe96f@V'ya8${57/T'"mTd`1o{TGYhHnVucLq!D$r2O{IN)7>.0op_Y`%r;/Q
 +(]`3F-t10N7NF\.Mm0q}p1:%iqTi:5]1E]rDF)R$9.!,Eu'9K':y9^U3F8UCS1M+A$
 8[[[WT^`$P[vu>P+8]aQMh9giu&fPCqLW2FSsGs
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Cancel-Lock: sha1:lq7wnmE/La5rK5vNnprj9fq0mKw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

If I understand correctly, packets sent to the all-ones
broadcast address only go out through a single interface.

My question is threefold:

 1. Why doesn't Linux send 255.255.255.255 packages through
    all network interfaces?  (I realize that this is
    probably not a Linux-specific question.)

 2. How does it choose which interface to send through?
    My first guess was that it just took the first Ethernet
    interface and used that for broadcasting.  But playing
    around with nameif, this seems not to be the case.

 3. Can I set the default broadcast interface explicitly?
    For example, say I wanted broadcasts to go out over eth1
    by default, instead of over eth0.  What if I wanted them
    to get sent through tap0?

Yes, I know that what I *should* be doing is just send the
packages to the broadcast address specific to the network
where I want them to go.  (That is, I should be sending them
to 10.255.255.255 instead of 255.255.255.255 if I want them
to be broadcast to the 10.0.0.0 network.)

Unfortunately, this is not a viable option in my case, as
I'm dealing with a closed-source application that
unconditionally sends broadcasts to 255.255.255.255.
Ideally, the application would let me choose which interface
to broadcast to, but alas it does not.

I've tried searching for a solution to this problem on the
web and on IRC with no luck, so now I'm turning to you guys.


Thanks in advance,

-- 
Daniel Brockman <daniel@brockman.se>

