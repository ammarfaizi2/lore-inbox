Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVI2TVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVI2TVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVI2TVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:21:53 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:39539 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932285AbVI2TVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:21:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=b50DaS/wyfdyUEq8KDrdbYRObe3fXzrbpIwoTv0Q/rh0J9kr7r/n2YB/DH29AysQ/bCGcBFpSAlEtw1T3l+YgYyq/TnzWoHrjJgHnMWpoHguw32nUH0LNXv5li2YU0LFyeIfA4KprgwFD+rU4Lord4641/iKGuFRTg9VMdWaUm8=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [patch 1/1] cpufreq_conservative: invert meaning of 'ignore_nice'
Date: Thu, 29 Sep 2005 13:46:33 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       alex-kernel@digriz.org.uk
References: <20050929084435.GC3169@inskipp.digriz.org.uk>
In-Reply-To: <20050929084435.GC3169@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509291346.33855.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 September 2005 10:44, Alexander Clouter wrote:
> The use of the 'ignore_nice' sysfs file is confusing to anyone using.  This
> patch makes it so when you now set it to the default value of 1, process
> nice time is also ignored in the cpu 'busyness' calculation.

> Prior to this patch to set it to '1' to make process nice time count...even
> confused me :)

> WARNING: this obvious breaks any userland tools that expect things to be
> the other way round.  This patch clears up the confusion but should go in
> ASAP as at the moment it seems very few tools even make use of this
> functionality; all I could find was a Gentoo Wiki entry.

My suggestion on this is to rename the flag too, as ignore_nice_load (or 
ignore_nice_tasks, choose your way). Don't forget to do it in docs too.

So userspace tools will error out rather than do the reverse of what they were 
doing, and the user will fix the thing according to the (new) docs.

This is the way we avoid problems in kernel code, when changing APIs (I read 
Linus talking about this), so I assume it's ok?

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
