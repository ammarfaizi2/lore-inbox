Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269455AbRGaUxN>; Tue, 31 Jul 2001 16:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269462AbRGaUxD>; Tue, 31 Jul 2001 16:53:03 -0400
Received: from weta.f00f.org ([203.167.249.89]:52358 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269455AbRGaUw4>;
	Tue, 31 Jul 2001 16:52:56 -0400
Date: Wed, 1 Aug 2001 08:53:36 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Pekka Savola <pekkas@netcore.fi>
Cc: kuznet@ms2.inr.ac.ru, therapy@endorphin.org, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: missing icmp errors for udp packets
Message-ID: <20010801085336.C8400@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0107312249230.20772-100000@netcore.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107312249230.20772-100000@netcore.fi>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 10:59:39PM +0300, Pekka Savola wrote:

    bad ping responder == bad PR ;-)

    And anyway, who is anyone to judge what the system should be used
    for?

    I want a system to respond to ping without limitations; it's good
    for debugging, diagnostics, etc.  If I want, I can just filter the
    requests out, or rate-limit the responses.

People who want to do strange stuff can tweak via sysctl.

    However, ICMP error messages cannot be effectively filtered; they
    may happen due to TTL=0 when forwarding, legit or illegit UDP
    connection etc.; only way to effectively limit them is by
    rate-limiting.  If rate-limiting with informational and error
    types are the same, we have an inflexible situation here.

Networks are lossy, you can spill the odd packet anyhow.

It was just a suggestion that we merge all ICMP rate-limiting for
simplicity, I don't see it being an issue for the majority of users.

Perhaps I am wrong, in which case DaveM and Alexey will ignore me :)

I really don't see the need to continue to discuss this further on the
list, but by all means flame me in private!





  --cw
