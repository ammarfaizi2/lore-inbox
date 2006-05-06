Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWEFXDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWEFXDa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 19:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWEFXDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 19:03:30 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:55486 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S932100AbWEFXDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 19:03:30 -0400
Date: Sun, 7 May 2006 01:03:20 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Jason Schoonover <jasons@pioneer-pra.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Message-ID: <20060506230320.GA3463@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Jason Schoonover <jasons@pioneer-pra.com>,
	linux-kernel@vger.kernel.org
References: <200605051010.19725.jasons@pioneer-pra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605051010.19725.jasons@pioneer-pra.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 10:10:19AM -0700, Jason Schoonover wrote:

> Whenever I copy any large file (over 500GB) the load average starts to slowly 
> rise and after about a minute it is up to 7.5 and keeps on rising (depending 
> on how long the file takes to copy).  When I watch top, the processes at the 
> top of the list are cp, pdflush, kjournald and kswapd.

Load average is a bit of an odd metric in this case, try looking at the
output from 'vmstat 1', and especially the 'id' column. As long as that
doesn't rise, you don't have an actual problem.

The number of processes in the runqueue doesn't really tell you anything
about how much CPU you are using.

Having said that, I think there might be a problem to be solved.

	Bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
