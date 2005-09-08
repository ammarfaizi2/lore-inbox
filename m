Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbVIHNfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVIHNfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 09:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbVIHNfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 09:35:41 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:45790 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1751353AbVIHNfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 09:35:40 -0400
Date: Thu, 8 Sep 2005 15:35:26 +0200 (CEST)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Tommy Christensen <tommy.christensen@tpack.net>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>
Subject: Re: [PATCH] 3c59x: read current link status from phy
In-Reply-To: <1126184700.4805.32.camel@tsc-6.cph.tpack.net>
Message-ID: <Pine.LNX.4.63.0509081521140.21354@dingo.iwr.uni-heidelberg.de>
References: <200509080125.j881PcL9015847@hera.kernel.org>  <431F9899.4060602@pobox.com>
  <Pine.LNX.4.63.0509081351160.21354@dingo.iwr.uni-heidelberg.de>
 <1126184700.4805.32.camel@tsc-6.cph.tpack.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2005, Tommy Christensen wrote:

> The idea is to avoid an extra delay of 60 seconds before detecting 
> link-up.

But you are adding the read to a function that is called repeatedly to 
fix an event that happens only once at start-up !

If this read is really needed (I still doubt it...), can't it be 
performed in vortex_up(), by possibly doubling the existing one there ?
vortex_up() is executed only once at start-up, not every 60 seconds.

> Please see http://bugzilla.kernel.org/show_bug.cgi?id=5025

Hah, a Cisco switch.  Look in Documentation/networking/vortex.txt for 
"portfast".

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
