Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129748AbQJaNAH>; Tue, 31 Oct 2000 08:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbQJaM75>; Tue, 31 Oct 2000 07:59:57 -0500
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:7150 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S129748AbQJaM7i>; Tue, 31 Oct 2000 07:59:38 -0500
Message-ID: <39FEC1FE.A6AB5C2A@didntduck.org>
Date: Tue, 31 Oct 2000 07:58:38 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: kmalloc() allocation.
In-Reply-To: <E13qJZL-00076K-00@the-village.bc.nu> <Pine.LNX.3.95.1001030133720.3346A-100000@chaos.analogic.com> <8tll94$hc9$1@cesium.transmeta.com> <39FE6291.FA8162A7@didntduck.org> <20001031094445.A24901@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Tue, Oct 31, 2000 at 01:11:29AM -0500, Brian Gerst wrote:
> > This was just changed in 2.4 so that vmalloced pages are faulted in on
> > demand.
> 
> Could you explain how it handles the vmalloc() -- vfree() -- vmalloc() of same
> virtual space but different physical race ?

As far as I can tell (I didn't write the code), vfree didn't change. 
It's only vmalloc that's lazy now.

-- 

						Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
