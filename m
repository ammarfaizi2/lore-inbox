Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267078AbTBVRA1>; Sat, 22 Feb 2003 12:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267106AbTBVRA1>; Sat, 22 Feb 2003 12:00:27 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32642
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267078AbTBVRA0>; Sat, 22 Feb 2003 12:00:26 -0500
Subject: Re: [ak@suse.de: Re: iosched: impact of streaming read on
	read-many-files]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrea@suse.de
In-Reply-To: <20030221230716.630934cf.akpm@digeo.com>
References: <20030222054307.GA22074@wotan.suse.de>
	 <20030221230716.630934cf.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045937514.5038.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 22 Feb 2003 18:11:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-22 at 07:07, Andrew Morton wrote:
> No, we do not really need to implement RLIM_MEMLOCK for such applications.
> They can leave their memory unlocked for any reasonable loads.
> 
> Yes, we _do_ need to give these applications at least elevated scheduling
> priority, if not policy, so they get the CPU in a reasonable period of
> time.

It isnt about CPU, its about disk. If the app gets a code page swapped
out then unless we have disk as well as cpu priority, or we do memlock
stuff you are screwed. I guess the obvious answer with 2.5 is to 
simply abuse the futex bugs and lock down futex pages with code in ;)

