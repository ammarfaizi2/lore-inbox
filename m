Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264026AbUDVNS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbUDVNS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 09:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbUDVNS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 09:18:56 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:10757 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264026AbUDVNSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 09:18:55 -0400
Date: Thu, 22 Apr 2004 15:17:04 +0200
From: Willy Tarreau <w@w.ods.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
Message-ID: <20040422131704.GA6839@alpha.home.local>
References: <XFMail.20040422102359.pochini@shiny.it> <Pine.LNX.4.53.0404220734330.8039@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0404220734330.8039@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 07:35:54AM -0400, Richard B. Johnson wrote:
 
> Has anybody checked to see what Linux does if it receives a
> RST to the broadcast address? It would be a shame if all
> connections were dropped!

I don't see how this would be possible : a TCP packet is matched *only* if
it refers to a valid session. If you have no session established from/to the
broadcast address, there's no possibility that an RST targetted at this address
terminates anything, even if the ports are OK.

Cheers,
Willy

