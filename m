Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313505AbSFJN0Y>; Mon, 10 Jun 2002 09:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314227AbSFJN0X>; Mon, 10 Jun 2002 09:26:23 -0400
Received: from [64.76.155.18] ([64.76.155.18]:49828 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S313505AbSFJN0W>;
	Mon, 10 Jun 2002 09:26:22 -0400
Date: Sat, 8 Jun 2002 22:51:05 -0400 (CLT)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: "Nix N. Nix" <nix@go-nix.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: ip_nat_irc & 2.4.18
In-Reply-To: <1023589926.8435.1.camel@tux>
Message-ID: <Pine.LNX.4.44.0206082249240.5254-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jun 2002, Nix N. Nix wrote:

> 
> I figured it out:
> 
> ip_nat_irc.o doesn't track connection going to ports other than 6667. 
> So, if, initially, you connect to, say, twisted.ma.us.dal.net:6668, then
> ip_nat_irc doesn't track your connection. :o(
> 

Hi, from ip_nat_irc.c

-- snip --
 *      Module load syntax:
 *      insmod ip_nat_irc.o ports=port1,port2,...port<MAX_PORTS>
 *      
 *      please give the ports of all IRC servers You wish to connect to.
 *      If You don't specify ports, the default will be port 6667
 */
-- snip --

You should change your insmod line for ip_nat_irc to include all port 
you're supposed to connect to.

Hope this helps

Best regards.
-- 
Robinson Maureira Castillo
Asesor DAI
INACAP

