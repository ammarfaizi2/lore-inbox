Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbULOUqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbULOUqG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 15:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbULOUqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 15:46:06 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:56798 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S262478AbULOUqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 15:46:05 -0500
To: Adam Denenberg <adam@dberg.org>
Cc: linux-os@analogic.com, Jan Harkes <jaharkes@cs.cmu.edu>,
       Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: bind() udp behavior 2.6.8.1
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
	<1103141991.6825.17.camel@sucka>
From: Doug McNaught <doug@mcnaught.org>
Date: Wed, 15 Dec 2004 15:45:54 -0500
In-Reply-To: <1103141991.6825.17.camel@sucka> (Adam Denenberg's message of
 "Wed, 15 Dec 2004 15:19:51 -0500")
Message-ID: <87oegv5lz1.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Denenberg <adam@dberg.org> writes:

> sorry for any confusion, but i am not referring to the Identification
> field in the IP header but rather the "Transaction ID" field in the DNS
> query portion of the packet.  I can reproduce this behavior on our linux
> system where if i pump gethostbyname_r requests on the system at some
> point it will reuse a transaction id in the DNS request.  This is my
> lastest discovery in what is causing the requests to fail thru the
> firewall.  So far my research has not turned up any reason as to why the
> kernel would be re-using a transaction ID in the dns request.

That would be your DNS software reusing the transaction ID, since it's
part of the packet data, not the UDP header.  The kernel has nothing
to do with it.

-Doug
