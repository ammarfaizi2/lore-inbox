Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTDPXkS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 19:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTDPXkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 19:40:17 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:48793 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S261844AbTDPXkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 19:40:16 -0400
Date: Thu, 17 Apr 2003 01:52:09 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Steve Kinneberg <kinnebergsteve@acmsystems.com>
Cc: Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Linux1394dev <linux1394-devel@lists.sourceforge.net>
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then
 hard freeze ( lockup on CPU0)
Message-Id: <20030417015209.1da13235.philippe.gramoulle@mmania.com>
In-Reply-To: <1050536111.1899.2246.camel@stevek>
References: <20030416000501.342c216f.philippe.gramoulle@mmania.com>
	<20030415160530.2520c61c.akpm@digeo.com>
	<20030416004933.GI16706@phunnypharm.org>
	<20030416184528.19c20372.philippe.gramoulle@mmania.com>
	<1050514375.589.1843.camel@stevek>
	<20030417003031.2b603167.philippe.gramoulle@mmania.com>
	<1050536111.1899.2246.camel@stevek>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws87 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Apr 2003 16:35:10 -0700
Steve Kinneberg <kinnebergsteve@acmsystems.com> wrote:

  | > Since then, i only got these "reset storms" versions over versions. Not that i complain about
  | > but it's just that i hope that reporting bugs will be helpful to IEEE1394 developers, because
  | > if it worked once,  then i don't see why i wouldn't work either with newer versions 8)
  | 
  | The code that prints "ieee1394: Remote root is not IRM capable,
  | resetting..." was added almost 2 months ago to the 1394 SVN trunk, so
  | its still fairly recent and probably after 2.5.59.

I'm rather sure it was around 2.5.59 but i couldn't swear about the exact time frame
as it might be a BK snapshot at the time.

  | If this message repeats rapidly under recent 2.5.*, then there is a
  | problem with initiating a bus reset and forcing the local node to be
  | root.


Well with 2.6.57-mm3 + latest SVN checkout, it has about 1 such line per second 
in my logs as soon as i turn on my DV Camcorder.

  
  | My recollection of the 1394 spec is that PHY packet needs to be sent out to
  | all nodes to clear the their root hold-off bit and the local node sets
  | its own root hold-off bit.  The OHCI 1394 code doesn't appear to do
  | anything special to send a PHY packet (it does set the root hold-off bit
  | in the local PHY chip) and I wonder if that might not be the source of
  | this problem.  Does anyone, who understands the PHY chip, know if it
  | automatically sends the appropriate PHY packet when this bit is set?  If
  | not, we may need to add code to send it.
  | 
  | If anyone can answer the one question I posed above, I'd greatly
  | appreciate it.

I'll happily let someone else answer :)

Thanks,

Philippe
