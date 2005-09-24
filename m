Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVIXQEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVIXQEW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 12:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVIXQEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 12:04:22 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:51982 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1750750AbVIXQEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 12:04:21 -0400
Message-ID: <433578EE.6070402@symas.com>
Date: Sat, 24 Sep 2005 09:03:58 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20050924 SeaMonkey/1.1a
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Serious time drift - clock running fast
References: <Pine.LNX.4.58.0509231913550.5348@shell3.speakeasy.net> <9a8748490509240752436ef7b2@mail.gmail.com>
In-Reply-To: <9a8748490509240752436ef7b2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having the same problem with 2.6.13, AMD64 X2, Asus A8V Deluxe 
motherboard. What's worse is that this is my local net's NTP server, so 
it's taking all my other machines' clocks along for the ride, and I'm 
losing my associations to the upper strata servers because the skew gets 
too great. (So ntpd needs to be restarted periodically.)

I've seen earlier reports on this list about the clock running twice 
normal speed. That's not what I'm seeing here; after several hours it's 
only ahead by 5 minutes at the moment. (The system has been up 20 days, 
but I restarted ntpd a few hours ago, and it resync'd via ntpdate at 
that point.) Maybe it would be running at 2X if I kill ntpd, I haven't 
checked that.

If it matters, I configured a 250Hz clock tick on this kernel.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

