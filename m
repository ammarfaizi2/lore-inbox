Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129719AbQJaJZg>; Tue, 31 Oct 2000 04:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129858AbQJaJZQ>; Tue, 31 Oct 2000 04:25:16 -0500
Received: from Cantor.suse.de ([194.112.123.193]:14604 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129719AbQJaJZJ>;
	Tue, 31 Oct 2000 04:25:09 -0500
Date: Tue, 31 Oct 2000 10:25:00 +0100
From: Andi Kleen <ak@suse.de>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Brian Gerst <bgerst@didntduck.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: kmalloc() allocation.
Message-ID: <20001031102500.A25854@gruyere.muc.suse.de>
In-Reply-To: <20001031095410.A25158@gruyere.muc.suse.de> <Pine.LNX.4.21.0010310906310.1604-100000@saturn.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0010310906310.1604-100000@saturn.homenet>; from tigran@veritas.com on Tue, Oct 31, 2000 at 09:07:29AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 09:07:29AM +0000, Tigran Aivazian wrote:
> On Tue, 31 Oct 2000, Andi Kleen wrote:
> 
> > On Tue, Oct 31, 2000 at 08:49:02AM +0000, Tigran Aivazian wrote:
> > > 
> > > what do you mean?! That is, of course, impossible because it would break
> > > all existing software, so I won't even bother checking the code, safely 
> > > assuming that you perhaps meant something else, ok?
> > 
> > He refers to faulting into the page table from a master table, not faulting 
> > from disk.
> > 
> 
> Ah, ok then. Thanks Andi, I was a bit worried that the world has changed 
> too radically for me to catch up :)

Well, unless I'm missing something major the new method is racy (it does 
not handle vmalloc-vfree-vmalloc of same area on a different CPU)

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
