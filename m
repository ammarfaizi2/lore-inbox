Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBUNeU>; Wed, 21 Feb 2001 08:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBUNeK>; Wed, 21 Feb 2001 08:34:10 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:48400 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129051AbRBUNeB>;
	Wed, 21 Feb 2001 08:34:01 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mager@tzi.de (Markus Germeier), linux-kernel@vger.kernel.org,
        davem@redhat.com
Subject: Re: Problem with 2.2.19pre9 (Connection closed.)
In-Reply-To: <E14VZCs-00023R-00@the-village.bc.nu>
From: Jes Sorensen <jes@linuxcare.com>
Date: 21 Feb 2001 14:32:50 +0100
In-Reply-To: Alan Cox's message of "Wed, 21 Feb 2001 13:21:20 +0000 (GMT)"
Message-ID: <d3g0h8nou5.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> after upgrading to 2.2.19pre9 (+ 2 NFS-patches, IPv6 enabled) idle
>> connections tend to shut down without a visible reason:

Alan> Yes I've seen this too. It seems that the tcp changes broke the
Alan> keepalive handling somewhere when I leave a non Linux target
Alan> idle.

I reported this on netdev last week as well.

I only see this for connections with incoming traffic where I don't
send something out (like irc), whereas unused ssh connections seem to
survive fine.

Hopefully another hint that could help nailing the bug.

Jes
