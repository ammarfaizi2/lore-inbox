Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319199AbSHNEiT>; Wed, 14 Aug 2002 00:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319200AbSHNEiT>; Wed, 14 Aug 2002 00:38:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54802 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319199AbSHNEiS>; Wed, 14 Aug 2002 00:38:18 -0400
Date: Tue, 13 Aug 2002 21:44:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@zip.com.au>,
       "H. Peter Anvin" <hpa@zytor.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
In-Reply-To: <20020814003505.A16322@redhat.com>
Message-ID: <Pine.LNX.4.44.0208132142310.1208-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Aug 2002, Benjamin LaHaise wrote:
> 
> /dev/kmsg was another suggestion for the name.  But please revert the 
> yet-another-syscall variant -- having a duplicate way for logging that 
> doesn't work with stdio just seems sick to me (sys_syslog should die).

Actually, anybody who uses stdio on syslog messages should be roasted. 
Over the nice romantic glow of red-hot coal, slowly cooking the stupid git 
alive.

It's not a bug, it's a feature. A syslog message needs to be atomic, which 
means that it MUST NOT use the buffering of stdio. 

		Linus

