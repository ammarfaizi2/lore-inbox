Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317520AbSFICcH>; Sat, 8 Jun 2002 22:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317536AbSFICcG>; Sat, 8 Jun 2002 22:32:06 -0400
Received: from smtp.cogeco.net ([216.221.81.25]:54210 "EHLO fep6.cogeco.net")
	by vger.kernel.org with ESMTP id <S317520AbSFICcG>;
	Sat, 8 Jun 2002 22:32:06 -0400
Subject: Re: ip_nat_irc & 2.4.18
From: "Nix N. Nix" <nix@go-nix.ca>
To: "Nix N. Nix" <nix@go-nix.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1023530798.29159.2.camel@tux>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Jun 2002 22:32:06 -0400
Message-Id: <1023589926.8435.1.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-06-08 at 06:06, Nix N. Nix wrote:
> Does ip_nat_irc not work with 2.4.18 ?  All my old fserves have stopped
> working.  If I try logging in from the outside (for, say, a DCC file
> xfer), I get "Connection Refused" in the client.  I believe it ran fine
> with 2.4.17.  What's wrong ?

I figured it out:

ip_nat_irc.o doesn't track connection going to ports other than 6667. 
So, if, initially, you connect to, say, twisted.ma.us.dal.net:6668, then
ip_nat_irc doesn't track your connection. :o(

> 
> 
> 
> Please help.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


