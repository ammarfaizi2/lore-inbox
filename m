Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWEDWL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWEDWL4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 18:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWEDWL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 18:11:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50410 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750814AbWEDWLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 18:11:55 -0400
Subject: Re: TCP/IP send, sendfile, RAW
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roy Rietveld <rwm_rietveld@hotmail.com>
Cc: linux-os@analogic.com, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de
In-Reply-To: <BAY105-F166097660AAB32A85D4DD6E9B40@phx.gbl>
References: <BAY105-F166097660AAB32A85D4DD6E9B40@phx.gbl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 04 May 2006 23:22:58 +0100
Message-Id: <1146781378.24513.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-04 at 18:42 +0000, Roy Rietveld wrote:
> i tried but it doesn't help, still 40MBits. Does send or sento cost a lot of 
> cpu load.

That depends a lot on your hardware: Each UDP or TCP packet has to be
checksummed  and loaded onto the network chip so there is memory
bandwidth used. There is also some CPU load but they are not horribly
complex code paths. Much of the performance depend son the network chip

