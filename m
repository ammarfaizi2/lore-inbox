Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129834AbRAZCQR>; Thu, 25 Jan 2001 21:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130032AbRAZCQH>; Thu, 25 Jan 2001 21:16:07 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14088 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129904AbRAZCPz>; Thu, 25 Jan 2001 21:15:55 -0500
Message-ID: <3A70DDC4.6D1DB1EC@transmeta.com>
Date: Thu, 25 Jan 2001 18:15:32 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
		<94qcvm$9qp$1@cesium.transmeta.com>
		<14960.54069.369317.517425@pizda.ninka.net>
		<3A70D524.11362EFB@transmeta.com>
		<14960.54852.630103.360704@pizda.ninka.net>
		<3A70D7B2.F8C5F67C@transmeta.com> <14960.56461.296642.488513@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> It says "reserved for future use, must be zero".
> 
> I think the descrepency (and thus what the firewalls are doing) comes
> from the ambiguous "must be zero".  I cannot fathom the RFC authors
> meaning this to be anything other than "must be set to zero by current
> implementations" or else what is the purpose of the "reserved for
> future use part" right?
> 
> Honestly, is there anyone here who can tell me honestly that when they
> see the words "reserved" in the description of a bit field description
> (in a hardware programmers manual of some device, for example) that
> they think it's ok the read the value and interpret it in any way?
> 
> To me it's always meant "we want to do cool things in the future,
> things we haven't thought of now, so don't interpret these bits so we
> can do that and you will still work".
> 

Think of yourself as a firewall author now.  You come across this, and
go, "these bits aren't used now; this means noone should be setting
them.  I have no guarantee that anything in the future isn't going to use
these bits for something that isn't going to override the security of my
system."

MBZ to me indicate that it is legitimate for the recipient to drop them
as invalid if they are not.  This is probably unfortunate; they really
need specific definition about what the sender should do (set the bits to
zero) and the recipient should do (ignore the bits.)

Unfortunately, it's hard to be "liberal in what you accept" when you're
trying to enforce a security policy.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
