Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWEDTtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWEDTtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 15:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWEDTtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 15:49:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:18957 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030308AbWEDTtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 15:49:14 -0400
Date: Thu, 4 May 2006 21:48:42 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Roy Rietveld <rwm_rietveld@hotmail.com>
Cc: linux-os@analogic.com, linux-kernel@vger.kernel.org
Subject: Re: TCP/IP send, sendfile, RAW
Message-ID: <20060504194842.GC11191@w.ods.org>
References: <Pine.LNX.4.61.0605041459220.7134@chaos.analogic.com> <BAY105-F38F372575F5B72AF1DACE6E9B40@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY105-F38F372575F5B72AF1DACE6E9B40@phx.gbl>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 07:43:34PM +0000, Roy Rietveld wrote:
> i Think the resolution of gettimeofday is 1us because
> gettimeofday(start)
> gettimeofday(end)
> 
> end - start gives 1
> 
> so when i leave out gettimeofday
> 
> while(1)
> {
> sendto(socket,buffer,1400,....)
> }
> 
> i measured with ethereal 4000 packets per second

Are you sure you are not limited by the interrupt rate ? may be interrupt
processing causes a large overhead at 4000/s for 177 MHz, and you might
need to find a way to either use interrupt mitigation or polling.

Regards,
Willy

