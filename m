Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129237AbQKLP4w>; Sun, 12 Nov 2000 10:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129987AbQKLP4n>; Sun, 12 Nov 2000 10:56:43 -0500
Received: from Cantor.suse.de ([194.112.123.193]:29457 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129237AbQKLP43>;
	Sun, 12 Nov 2000 10:56:29 -0500
Date: Sun, 12 Nov 2000 16:44:17 +0100
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Tigran Aivazian <tigran@veritas.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001112164417.A10464@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet> <m1ofzmcne5.fsf@frodo.biederman.org> <20001112122910.A2366@athlon.random> <m1k8a9badf.fsf@frodo.biederman.org> <20001112163705.A4933@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001112163705.A4933@athlon.random>; from andrea@suse.de on Sun, Nov 12, 2000 at 04:37:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 04:37:05PM +0100, Andrea Arcangeli wrote:
> > I can tell you don't have real hardware.  The non obviousness
> 
> Current code definitely works fine on the simnow simulator so if current code
> shouldn't work because it's buggy then at least the simulator is sure buggy as
> well (and that isn't going to be the case as its behaviour is in full sync with
> the specs as far I can see).

The current simulator seems to be buggy in that it checks the SS,DS segments
that were pushed as part of the interrupt stack on iretd (which it 
IMHO shouldn't according to the spec). We currently need to have a valid kernel
DS to make the interrupts work.  


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
