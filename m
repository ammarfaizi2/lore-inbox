Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLXJpq>; Sun, 24 Dec 2000 04:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLXJph>; Sun, 24 Dec 2000 04:45:37 -0500
Received: from Cantor.suse.de ([194.112.123.193]:61965 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129319AbQLXJpX>;
	Sun, 24 Dec 2000 04:45:23 -0500
Date: Sun, 24 Dec 2000 10:14:55 +0100
From: Andi Kleen <ak@suse.de>
To: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP keepalive seems to send to only one port
Message-ID: <20001224101455.A11662@gruyere.muc.suse.de>
In-Reply-To: <20001223213156.A1947@flower.cesarb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001223213156.A1947@flower.cesarb>; from cesarb@nitnet.com.br on Sat, Dec 23, 2000 at 09:31:56PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2000 at 09:31:56PM -0200, Cesar Eduardo Barros wrote:
> 
> I've been doing some experiments with the keepalive code in 2.4.0-test10 here
> (I want to avoid the 2.2.x NAT I'm using (for which I don't have root) from
>  timing out my connections). To test it, I reduced both tcp_keepalive_time and
> tcp_keepalive_intvl to 1. Using ethereal, I saw that the keepalives were sent
> as expected, but only for one of the two idle TCP connections I had to a given
> host (I was testing with two remote hosts, each with two idle TCP connections,
> one in port 5500 and the other in port 5501). I only saw activity on 5500, yet
> netstat told me both were still active.

I just tried it and it works fine here with 2.4.0-test13-pre

You should be aware that the sysctls are only picked up after a timer timeout
or when a socket is newly created. When the sockets are already active it
takes a timeout for them to take effect. The default timeout is 2 hours.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
