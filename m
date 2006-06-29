Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWF2ERT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWF2ERT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 00:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWF2ERS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 00:17:18 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:23816 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S932139AbWF2ERS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 00:17:18 -0400
Date: Thu, 29 Jun 2006 14:18:27 +1000
From: CaT <cat@zip.com.au>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.17.1: fails to fully get webpage
Message-ID: <20060629041827.GJ2149@zip.com.au>
References: <20060629015915.GH2149@zip.com.au> <20060628.194627.74748190.davem@davemloft.net> <20060629030923.GI2149@zip.com.au> <20060628.204709.41634813.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628.204709.41634813.davem@davemloft.net>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 08:47:09PM -0700, David Miller wrote:
> You can save yourself that hassle by informing the site admin
> of the affected site that they have a firewall that misinterprets
> the RFC standard window scaling field of the TCP headers.  These
> devices assume it is zero because they don't remember the window
> scale negotiated at the beginning of the TCP connection.
> 
> Your TCP performance will suffer greatly if you disable window
> scaling across the board.  It means that only a 64K window will
> be usable by TCP, and you'll not be able to fill the pipe.
> 
> Please don't use a screwdriver to pound in a nail :)

Indeed. The hassle I'm thinking of is the reverse situation (and please
correct me if this does not apply). Say for example I run a web server.
I have customers and they have customers (lets call them CCs :). Somewhere
along the path between me and CCs there is such a misbehaving device.
The CCs try to get to my customers website and fail (I assume). If my
assumption is right, what's the probability of the CCs ever informing my
customer that there is a problem? I think it's more likely they would
just move on to another site offering the same thing, especially since
they would mostlikely need to load the site in order to get the
appropriate contact details.

Basically the mostlikely end-result is I don't know what there is a
problem and my customer doesn't know that there is a problem but they're
just not getting as many hits to their site that they otherwise would.

Ofcourse, this all depends if such a situation is possible. If it is
possible would it affect dns and mail in a similar manner too?

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
