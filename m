Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131546AbQJ2HQS>; Sun, 29 Oct 2000 02:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131556AbQJ2HQH>; Sun, 29 Oct 2000 02:16:07 -0500
Received: from Cantor.suse.de ([194.112.123.193]:60939 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131546AbQJ2HPy>;
	Sun, 29 Oct 2000 02:15:54 -0500
Date: Sun, 29 Oct 2000 08:15:53 +0100
From: Andi Kleen <ak@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Dave S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: tcp_do_sendmsg() allocation still broken ?
Message-ID: <20001029081553.A18159@gruyere.muc.suse.de>
In-Reply-To: <20001029020311.A16003@gruyere.muc.suse.de> <Pine.LNX.4.21.0010282345200.4224-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0010282345200.4224-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sat, Oct 28, 2000 at 11:46:37PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2000 at 11:46:37PM -0200, Rik van Riel wrote:
> Think about swap-over-network.

swap-over-network is unlikely to ever work properly without a preallocated 
skb pool, no matter if you use sk->allocation or not. 

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
