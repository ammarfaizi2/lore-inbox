Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTFGR7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 13:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTFGR7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 13:59:24 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:26823
	"EHLO michonline.com") by vger.kernel.org with ESMTP
	id S263311AbTFGR7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 13:59:23 -0400
Date: Sat, 7 Jun 2003 14:18:19 -0400
From: Ryan Anderson <ryan@michonline.com>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@cmf.nrl.navy.mil, wa@almesberger.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030607181818.GD20872@michonline.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	chas@cmf.nrl.navy.mil, wa@almesberger.net,
	linux-kernel@vger.kernel.org
References: <20030606210620.G3232@almesberger.net> <200306070047.h570lfsG003377@ginger.cmf.nrl.navy.mil> <20030606.235946.59661586.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606.235946.59661586.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 11:59:46PM -0700, David S. Miller wrote:
>    From: chas williams <chas@cmf.nrl.navy.mil>
>    Date: Fri, 06 Jun 2003 20:45:51 -0400
> 
>    really?  if i remove my ethernet interface i expect all the
>    connections to die.
>    
> Nope, this actually works.
> 
> Many a moon ago, we did this wrong and yes the TCP connections
> died.
> 
> But these days, definitely if you bring the interface back up
> with the same IP addresses, it just works and the connections
> recover.

FWIW, I seem to recall Windows doing this in older version, but with XP
it's very good about noticing link death, and killing things off.

I like the "correct" behavior much better, especially when dealing with
a combination of ethernet cables that have finicky ends and laptops that
get moved a little bit.  (Poof - cable slips out, all connections drop,
waste 5 minutes getting things retarted.)

-- 

Ryan Anderson
  sometimes Pug Majere
