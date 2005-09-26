Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbVIZL6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVIZL6S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 07:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbVIZL6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 07:58:17 -0400
Received: from mx03.cybersurf.com ([209.197.145.106]:35746 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S1751371AbVIZL6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 07:58:16 -0400
Subject: Re: [ANNOUNCE] Release of nf-HiPAC 0.9.0
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Emmanuel Fleury <fleury@cs.aau.dk>
Cc: Michael Bellion <mbellion@hipac.org>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <4337DA7C.2000804@cs.aau.dk>
References: <200509260445.46740.mbellion@hipac.org>
	 <4337DA7C.2000804@cs.aau.dk>
Content-Type: text/plain
Organization: unknown
Date: Mon, 26 Sep 2005 07:58:01 -0400
Message-Id: <1127735881.6215.294.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-26-09 at 13:24 +0200, Emmanuel Fleury wrote:
> Hi,
> 
> Did you solved your "size" issues when entering long list of rules ???
> 
> I'm still not convinced by your approach. :-/
> 
> These experiments have to be updated but can you comment on this:
> http://www.cs.aau.dk/~mixxel/cf/experiments.html

To repeat the tests i mentioned earlier for clarity:
a) Variable incoming packet rate (in packets per second)
b) Variable packet sizes
c) Variable number of users/filters
d) Effect of adding/removing/modifying policies while under different
incoming traffic rates.

You seem to have taken care of most of the variables involved except for
#d below. If you look at my slides you will see why #d is important to
have in modern firewalls. I think if you have to first compile rules
then you will have issues, but it remains to be seen.

Several comments:
- Am i mistaken that your source of data is from somewhere in the
backbone? Would it be fair to say that something in the edge would be
more appropriate?

- Your header extraction tool creates "10 sets of rules"; is there a
reason for the number 10?

- Is tcpreplay the right tool? What does it give you that you cant use a
better blaster like pktgen?

- I think the blackbox monitor looking at the input vs output tool is
good. It will be more complete if you can quantify the input rate then
you can easily quantify output rate.

- While your results were useful in showing Mbps; they are incomplete by
not mentioning the packet size. A better metric would have been pps. But
even then mentioning packet size is also useful.

If you are going to run these tests in stateless firewalling as you did,
please consider using tc filter as well.

cheers,
jamal

