Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136193AbRAZQ3m>; Fri, 26 Jan 2001 11:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136256AbRAZQ3e>; Fri, 26 Jan 2001 11:29:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:20751 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136193AbRAZQ3Z>; Fri, 26 Jan 2001 11:29:25 -0500
Message-ID: <3A71A5B5.7AE35C97@transmeta.com>
Date: Fri, 26 Jan 2001 08:28:37 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Lars Marowsky-Bree <lmb@suse.de>, James Sutherland <jas88@cam.ac.uk>,
        "David S. Miller" <davem@redhat.com>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <20010126124426.O2360@marowsky-bree.de> <Pine.SOL.4.21.0101261344120.11126-100000@red.csi.cam.ac.uk> <20010126154447.L3849@marowsky-bree.de> <20010126160342.B7096@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> Lars Marowsky-Bree wrote:
> > First, you are ignoring a TCP_RST, which means "stop trying".
> 
> That's why we stop when we receive the second TCP RST.
> It's just like dropping due to congestion, which is of course perfectly
> safe in moderation.
> 

No, you can't issue multiple connects in response to a single socket
option.  One can argue that it would have been OK for these firewalls to
drop ECN packets, but replying with RST is just too broken to live.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
