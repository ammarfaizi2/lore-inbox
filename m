Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312850AbSCVVlJ>; Fri, 22 Mar 2002 16:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312851AbSCVVk7>; Fri, 22 Mar 2002 16:40:59 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:7135 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S312850AbSCVVkt>;
	Fri, 22 Mar 2002 16:40:49 -0500
Date: Fri, 22 Mar 2002 22:40:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Joerg Pommnitz <pommnitz@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I want my martians
Message-ID: <20020322224019.A3252@ucw.cz>
In-Reply-To: <20020322102058.73815.qmail@web13306.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2002 at 02:20:58AM -0800, Joerg Pommnitz wrote:
> Hi List,
> as I wrote in
> http://marc.theaimsgroup.com/?l=linux-net&m=101672497502530&w=2 I'm trying
> to send packets from one network interface to another one on the same
> machine over the external network. This almost works except for the fact
> that the Linux IP stack considers these packets to be "martians" and drops
> them. While this might be a good idea for normal operation it prevents me
> from doing what I want: network latency and reliability measurements.
> 
> So, is there a way to convince the Linux kernel that these martians are
> not here to take over the world but just harmless little packets that
> should be delivered to the waiting application?

for a in /proc/sys/net/ipv4/conf/*/rp_filter; do echo 0 > $a; done

-- 
Vojtech Pavlik
SuSE Labs
