Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318124AbSHDPnP>; Sun, 4 Aug 2002 11:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318164AbSHDPnP>; Sun, 4 Aug 2002 11:43:15 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:11427 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318124AbSHDPmX>; Sun, 4 Aug 2002 11:42:23 -0400
Date: Sun, 4 Aug 2002 16:45:23 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Dead code in i386/kernel/process.c
Message-ID: <20020804164523.A3970@kushida.apsleyroad.org>
References: <3D4C5B8E.5060009@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D4C5B8E.5060009@quark.didntduck.org>; from bgerst@quark.didntduck.org on Sat, Aug 03, 2002 at 06:39:10PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> This patch removes an artifact of code left over from the 2.0 days when 
> the kernel didn't use flat segments.

This code dates back to a patch for 1.2.8 :-)
The comment is quite wrong now.

Can we trust that arch/i386/mm/init.c will continue to map the page at
0xc0000000 (PAGE_OFFSET) to physical address 0?  I guess so, hence the
patch is fine.

-- Jamie
