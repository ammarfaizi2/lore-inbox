Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbULOUtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbULOUtD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 15:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbULOUtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 15:49:02 -0500
Received: from bigeats.dufftech.com ([69.57.156.29]:10651 "HELO
	bigeats.dufftech.com") by vger.kernel.org with SMTP id S262485AbULOUsx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 15:48:53 -0500
Subject: Re: bind() udp behavior 2.6.8.1
From: Adam Denenberg <adam@dberg.org>
To: Doug McNaught <doug@mcnaught.org>
Cc: linux-os@analogic.com, Jan Harkes <jaharkes@cs.cmu.edu>,
       Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <87oegv5lz1.fsf@asmodeus.mcnaught.org>
References: <1103038728.10965.12.camel@sucka>
	 <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr>
	 <1103042538.10965.27.camel@sucka>
	 <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr>
	 <1103043716.10965.40.camel@sucka>
	 <8AF1BC56-4E1C-11D9-B94B-000393ACC76E@mac.com>
	 <57782EC8-4E40-11D9-B971-003065B11AE8@dberg.org>
	 <20F668EE-4E48-11D9-B94B-000393ACC76E@mac.com>
	 <1103120162.5517.14.camel@sucka>
	 <20041215190725.GA24635@delft.aura.cs.cmu.edu>
	 <1103138573.6825.11.camel@sucka>
	 <Pine.LNX.4.61.0412151459150.4365@chaos.analogic.com>
	 <1103141991.6825.17.camel@sucka>  <87oegv5lz1.fsf@asmodeus.mcnaught.org>
Content-Type: text/plain
Message-Id: <1103143730.6825.19.camel@sucka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Dec 2004 15:48:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

but this would be an issue with glibc then correct?


On Wed, 2004-12-15 at 15:45, Doug McNaught wrote:
> Adam Denenberg <adam@dberg.org> writes:
> 
> > sorry for any confusion, but i am not referring to the Identification
> > field in the IP header but rather the "Transaction ID" field in the DNS
> > query portion of the packet.  I can reproduce this behavior on our linux
> > system where if i pump gethostbyname_r requests on the system at some
> > point it will reuse a transaction id in the DNS request.  This is my
> > lastest discovery in what is causing the requests to fail thru the
> > firewall.  So far my research has not turned up any reason as to why the
> > kernel would be re-using a transaction ID in the dns request.
> 
> That would be your DNS software reusing the transaction ID, since it's
> part of the packet data, not the UDP header.  The kernel has nothing
> to do with it.
> 
> -Doug
> 

