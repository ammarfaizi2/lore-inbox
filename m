Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQLXCvT>; Sat, 23 Dec 2000 21:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129458AbQLXCu7>; Sat, 23 Dec 2000 21:50:59 -0500
Received: from itaipu.nitnet.com.br ([200.255.111.241]:14611 "HELO
	itaipu.nitnet.com.br") by vger.kernel.org with SMTP
	id <S129595AbQLXCut>; Sat, 23 Dec 2000 21:50:49 -0500
Date: Sun, 24 Dec 2000 00:20:20 -0200
To: James Morris <jmorris@intercode.com.au>
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: TCP keepalive seems to send to only one port
Message-ID: <20001224002020.A2497@flower.cesarb>
In-Reply-To: <20001223223814.A2281@flower.cesarb> <Pine.LNX.4.31.0012241243440.17066-100000@blackbird.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0012241243440.17066-100000@blackbird.intercode.com.au>; from jmorris@intercode.com.au on Sun, Dec 24, 2000 at 12:52:12PM +1100
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24, 2000 at 12:52:12PM +1100, James Morris wrote:
> On Sat, 23 Dec 2000, Cesar Eduardo Barros wrote:
> 
> > Then what do you do when you are behind a NAT? And how do you expire entries in
> > ESTABLISHED state that could stay lingering forever without some sort of
> > keepalive? (The FINs might have been lost due to a conectivity transient, so
> > you can have another perfectly valid and alive connection with the same host,
> > and application-level timeouts are useless for some applications
> > (*cough*nc*cough*))
> 
> Typically, you choose a practical value for timing out inactive but
> otherwise seemingly established TCP connections.  The 2.4 connection
> tracking code (used for NAT) uses a value of five days for this.
> 

Yeah. But I'm stuck with a NAT (which isn't mine, btw) which uses 2.1.xxx-2.2.x
(according to nmap). Which had a default of 15 *minutes* (as I read in a HOWTO
somewhere). I'm trying to convince the sysadmin to raise it to two hours, but I
bet it'll be hard.

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
