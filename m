Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVGXS0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVGXS0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 14:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVGXS0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 14:26:19 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:22189 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261379AbVGXS0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 14:26:19 -0400
Date: Sun, 24 Jul 2005 20:26:18 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: linux-kernel@vger.kernel.org
Subject: do_gettimeofday monotony?
Message-ID: <20050724182617.GA15707@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is do_gettimeofday supposed to be monotonous? I'm seeing time go backward by
tiny amounts, and then progressing.

I'm using do_gettimeofday on a single processor, CONFIG_PREEMPT_NONE=y, and
saving stuff from generic_make_request - see http://ds9a.nl/diskstat for the
source. 2.6.13-rc3-mm1, HZ=250.

I'll try to figure out how much it is going back, and it is some kind of
magic interval.

Is there another monotonous clock in the kernel that doesn't wrap (all
that often)? Doesn't really need to be wall time.

Thanks!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
