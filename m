Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129082AbQJ3Mv1>; Mon, 30 Oct 2000 07:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129161AbQJ3MvQ>; Mon, 30 Oct 2000 07:51:16 -0500
Received: from Cantor.suse.de ([194.112.123.193]:28685 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129082AbQJ3Mu5>;
	Mon, 30 Oct 2000 07:50:57 -0500
Date: Mon, 30 Oct 2000 13:50:47 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030135047.A6209@gruyere.muc.suse.de>
In-Reply-To: <20001030010434.A19615@vger.timpanogas.org> <E13qELI-0006q0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13qELI-0006q0-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 30, 2000 at 12:47:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 12:47:10PM +0000, Alan Cox wrote:
> > We will never beat NetWare on scaling if this is the case, even in 2.4.  
> > Andre and my first job will be to create an arch port with MANOS that
> > disables this and restructures the VM.  
> 
> In the 2.4 case if you are just running NFS daemons then there are no tlb
> reloads going on at all. Whats murdering you is mostly memory copies. I would
> suspect if you rerun the profiles on a box with a much lower memory bandwidth
> that the effect will be even more visible

I don't think that's true. As far as I can see the nfsd processes do not do the
lazy VM magic (but it would be reasonably easy to add) 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
