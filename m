Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbTHSVEI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbTHSVD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:03:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:10687 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261467AbTHSVDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:03:33 -0400
Message-ID: <3F429039.8090905@us.ibm.com>
Date: Tue, 19 Aug 2003 17:01:45 -0400
From: Harley Stenzel <hstenzel@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, bloemsaa@xs4all.nl,
       richard@aspectgroup.co.uk, skraw@ithnet.com, willy@w.ods.org,
       alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
References: <353568DCBAE06148B70767C1B1A93E625EAB57@post.pc.aspectgroup.co.uk>	<070c01c36653$7f3c1ab0$c801a8c0@llewella>	<20030819083438.26c985b9.davem@redhat.com>	<20030819173920.GA3301@marowsky-bree.de> <20030819103613.4485e549.davem@redhat.com>
In-Reply-To: <20030819103613.4485e549.davem@redhat.com>
X-MIMETrack: Itemize by SMTP Server on D03NM118/03/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 08/19/2003 15:01:46,
	Serialize by Router on D03NM118/03/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 08/19/2003 15:01:49,
	Serialize complete at 08/19/2003 15:01:49
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> 
> And, as Alan said, we provide a way for one to obtain your networking
> religion of week.

To the best of my knowledge, there is presently no way to change the arp 
behavior of Linux such that it uses the interface-based arp mechanizm in 
  a manner compatable with load-balancing and hot-standby techniques 
involving aliasing the loopback interface.  In all the proposed 
solutions the cache-update by an arp request problem still exists (arp 
source ip problem).

I would love to be proven wrong.  Presently I have to either patch the 
kernel or suffer the throughput penalty of doing dnat to myself, all to 
do something that Solaris, AIX, HP-UX, *BSD, and even Windows can do 
natively.

--Harley

