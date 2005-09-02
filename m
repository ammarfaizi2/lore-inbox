Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVIBNxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVIBNxT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 09:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbVIBNxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 09:53:19 -0400
Received: from yakov.inr.ac.ru ([194.67.69.111]:63668 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S1751319AbVIBNxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 09:53:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=o9nz6pI30hanKd0PVBYUn88GOzn5CTcVhZoncBH8o1H0TybKmCsFCtZgJ24Vai9BGCSRxdoA/82aycqvWi3FfOYBD43MyT8D7aImEazAd+YDGFml2amyVHzYMXmVs7y7QZq3Mvph4wEAhORjSC/oeVE9LjjXLehawflFKMokprY=;
Date: Fri, 2 Sep 2005 17:52:56 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Guillaume Autran <gautran@mrv.com>
Cc: John Heffner <jheffner@psc.edu>, Ion Badulescu <lists@limebrokerage.com>,
       "David S. Miller" <davem@davemloft.net>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x kernels
Message-ID: <20050902135256.GC12617@yakov.inr.ac.ru>
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com> <20050901.154300.118239765.davem@davemloft.net> <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com> <2d02c76a84655d212634a91002b3eccd@psc.edu> <43184D79.6040009@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43184D79.6040009@mrv.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I experienced the very same problem but with window size going all the 
> way down to just a few bytes (14 bytes). dump files available upon 
> requests :)

I do request.

TCP is not allowed to reduce window to a value less than 2*MSS no matter
how hard network device or peer try to confuse it. :-)

Alexey
