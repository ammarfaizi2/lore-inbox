Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262396AbSJISdr>; Wed, 9 Oct 2002 14:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262399AbSJISdr>; Wed, 9 Oct 2002 14:33:47 -0400
Received: from blueberrysolutions.com ([195.165.170.195]:7061 "EHLO
	blueberrysolutions.com") by vger.kernel.org with ESMTP
	id <S262396AbSJISdp>; Wed, 9 Oct 2002 14:33:45 -0400
Date: Wed, 9 Oct 2002 21:39:18 +0300 (EEST)
From: Tony Glader <Tony.Glader@blueberrysolutions.com>
X-X-Sender: teg@blueberrysolutions.com
To: Chris Wright <chris@wirex.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: capable()-function
In-Reply-To: <20021009112254.A25393@figure1.int.wirex.com>
Message-ID: <Pine.LNX.4.44.0210092135240.411-100000@blueberrysolutions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Chris Wright wrote:

> > I was investigating problems with PCMCIA and found that
> > capable(CAP_SYS_ADMIN) returns always false in my case. If I'm calling
> Typically root has all effective capabilities (except CAP_SETPCAP).
> You can check your effective capabilities in /proc/[pid]/status.

In this case capable() call has been made from a kernel module. I think a
module doesn't have a PID? Should I check capabilites of program that does
a ioctl() call that will cause module to do capable() checking?

Process that does ioctl() call is owned by root and has following 
capabilities:

CapInh: 0000000000000000
CapPrm: 00000000fffffeff
CapEff: 00000000fffffeff
 
I think there are at least CAP_SYS_ADMIN capability.

-- 
* Tony Glader 

