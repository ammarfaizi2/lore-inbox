Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQKOVVv>; Wed, 15 Nov 2000 16:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129501AbQKOVVl>; Wed, 15 Nov 2000 16:21:41 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:56075 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129387AbQKOVVZ>; Wed, 15 Nov 2000 16:21:25 -0500
Message-ID: <3A12F72E.44C44FE2@transmeta.com>
Date: Wed, 15 Nov 2000 12:50:54 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11-pre5 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Michel LESPINASSE <walken@zoy.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: test11-pre5 breaks vmware
In-Reply-To: <CF021B54DF0@vcnet.vc.cvut.cz> <Pine.LNX.4.21.0011151454590.10690-100000@godzilla.spiteful.org> <8uuqmv$el4$1@cesium.transmeta.com> <20001115124931.B28499@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michel LESPINASSE wrote:
> 
> On Wed, Nov 15, 2000 at 12:12:15PM -0800, H. Peter Anvin wrote:
> > Also, if a piece of software needs raw CPUID information (unlike the
> > "cooked" one provided by recent kernels) it should use
> > /dev/cpu/*/cpuid.
> 
> Is it also OK to use the cpuid opcode in userspace ? (after checking
> for its presence with the 0x200000 eflags bit)
> 

Only on single-CPU systems.  What /dev/cpu/*/cpuid gives you is the
ability to direct the CPUID request to a particular CPU.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
