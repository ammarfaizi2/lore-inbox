Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRAIEhh>; Mon, 8 Jan 2001 23:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbRAIEh1>; Mon, 8 Jan 2001 23:37:27 -0500
Received: from Cantor.suse.de ([194.112.123.193]:31748 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129771AbRAIEhQ>;
	Mon, 8 Jan 2001 23:37:16 -0500
Date: Tue, 9 Jan 2001 05:37:13 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, mhvl@linuxia.ih.lucent.com,
        clubneon@hereintown.net, linux-kernel@vger.kernel.org
Subject: Re: Delay in authentication.gy
Message-ID: <20010109053713.A22827@gruyere.muc.suse.de>
In-Reply-To: <200101082117.NAA21459@pizda.ninka.net> <E14FkM5-0005Rv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14FkM5-0005Rv-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 08, 2001 at 10:01:26PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 10:01:26PM +0000, Alan Cox wrote:
> > It was intentionally changed because there is no way for the "ICMP
> > port unreachable" message coming back to be uniquely matched to that
> > UDP socket.  It can reset sockets illegally in high load scenerios.
> > 
> > Solaris and other systems act identically.
> 
> And have identical bad problems with auth failures. Right now I've given up
> trying to make 2.4 and YP mix because my RH setup assumes NIS auth will fail
> fast during boot up scripts and it doesnt.
> 
> Unfortunately for the quickfix folks, Dave is right about needing to sort it,
> and that means someone has to sort glibc to use the new interfaces

If anyone wants to fix and doesn't know how -- 
http://www.firstfloor.org/~andi/OLS/img27.htm and following slides describe the
Linux interface. Note that msg_name as original destination is not set in some 2.2 
kernels, so that needs to be handled too. 



-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
