Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266093AbRGEDin>; Wed, 4 Jul 2001 23:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265941AbRGEDiX>; Wed, 4 Jul 2001 23:38:23 -0400
Received: from chmls06.mediaone.net ([24.147.1.144]:24763 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S265861AbRGEDiM>; Wed, 4 Jul 2001 23:38:12 -0400
From: andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
Date: Wed, 4 Jul 2001 23:29:24 -0400
To: George Bonser <george@gator.com>
Cc: kern@wolf.ericsson.net.nz, linux-kernel@vger.kernel.org
Subject: Re: tcp stack tuning and Checkpoint FW1 & Legato Networker
Message-ID: <20010704232924.A13077@pimlott.ne.mediaone.net>
Mail-Followup-To: George Bonser <george@gator.com>,
	kern@wolf.ericsson.net.nz, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0107051331190.2882-100000@wolf.ericsson.net.nz> <CHEKKPICCNOGICGMDODJIELKDIAA.george@gator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <CHEKKPICCNOGICGMDODJIELKDIAA.george@gator.com>; from george@gator.com on Wed, Jul 04, 2001 at 07:02:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2001 at 07:02:36PM -0700, George Bonser wrote:
> > I want to set the tcp_keepalive timer to 60 seconds and understand
> > possible implications for Linux.
> 
> echo 60 >/proc/sys/net/ipv4/tcp_keepalive_time

By default, this is only polled by the kernel every 75 seconds, so
you would still lose.  In 2.2, this is hard-coded.  In 2.4,
/proc/sys/net/ipv4/tcp_keepalive_intvl will probably help, but I
haven't tried it.

Andrew
