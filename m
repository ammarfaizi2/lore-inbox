Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317763AbSGKEqm>; Thu, 11 Jul 2002 00:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317762AbSGKEql>; Thu, 11 Jul 2002 00:46:41 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:40106 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S317761AbSGKEqj>;
	Thu, 11 Jul 2002 00:46:39 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 10 Jul 2002 22:46:40 -0600
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, adam@yggdrasil.com, R.E.Wolff@BitWizard.nl,
       linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit
Message-ID: <20020710224640.S18791@host110.fsmlabs.com>
References: <200207041724.KAA06758@adam.yggdrasil.com> <20020711124830.26e2388b.rusty@rustcorp.com.au> <20020710.194555.88475708.davem@redhat.com> <20020710220244.K18791@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020710220244.K18791@host110.fsmlabs.com>; from cort@fsmlabs.com on Wed, Jul 10, 2002 at 10:02:44PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I checked out the sparc64 PTE structure.  It's not a bozo-design which I
thought it was (like some PPC's).  If you can select powers of 2 sizes my
concern is meaningless there since you can pick the appropriate
granularity.

A genuine Bershad-esque superpages design would be perfect there.

} Large PTE's aren't free either, though.  Cheap enough to implement but
} there's some fragmentation that isn't easy to deal with in some
} pathological cases.  The virtual space is pretty tight on some archs
} already.
} 
} A lot of stock distributions load most drivers as modules so a machine well
} stocked with devices may run into trouble.
} 
} } Modules can be mapped using a large PTE mapping.
} } I've been meaning to do this on sparc64 for a long
} } time.
} } 
} } So this TLB argument alone is not sufficient :-)
} } I do concur on the "ipv4 as module is difficult to
} } get correct" argument however.
} } -
} } To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} } the body of a message to majordomo@vger.kernel.org
} } More majordomo info at  http://vger.kernel.org/majordomo-info.html
} } Please read the FAQ at  http://www.tux.org/lkml/
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
