Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132688AbRAZR6x>; Fri, 26 Jan 2001 12:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135373AbRAZR6n>; Fri, 26 Jan 2001 12:58:43 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5907 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132688AbRAZR6c>; Fri, 26 Jan 2001 12:58:32 -0500
Message-ID: <3A71BA7F.9A3E7B03@transmeta.com>
Date: Fri, 26 Jan 2001 09:57:19 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <200101261753.JAA11559@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
>         I am surprised that anyone is seriously considering denying
> service to sites that do not implement an _experimental_ facility
> and have firewalls that try to play things safe by dropping packets
> which have 1's in bit positions that in the RFC "must be zero."
> 
>         If Microsoft were to do this with their favorite experimental
> network extensions for msnbc.com, how do you think the non-Microsoft
> world would feel and react?  Well, that's about how the rest of
> the world is likely to view this.
> 
>         That said, I wonder if some tweak to the Linux networking
> stack is possible whereby it would automatically disable ECN and retry
> on per socket basis if the connection establishment otherwise seems to
> be timing out.  This may be tricky given that the purpose of this
> facility is congestion notification, but, if someone is smart enough
> to be able to implement this, it would provide a much less disruptive
> migration path for adoption across firewalls that drop these packets.
> Far more sites could then safely activate this feature without limiting
> the hosts that they can reach.
> 
> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
> adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
> +1 408 261-6630         | g g d r a s i l   United States of America
> fax +1 408 261-6631      "Free Software For The Rest Of Us."

Ummm... we already went over this.  The fundamental problem is that they
aren't dropping the packets, they are sending RST.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
