Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbSKUTNo>; Thu, 21 Nov 2002 14:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266969AbSKUTNo>; Thu, 21 Nov 2002 14:13:44 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:12048 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S266967AbSKUTNn>;
	Thu, 21 Nov 2002 14:13:43 -0500
Date: Thu, 21 Nov 2002 20:20:45 +0100
From: Willy Tarreau <willy@w.ods.org>
To: David Zaffiro <davzaffiro@netscape.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling x86 with and without frame pointer
Message-ID: <20021121192045.GE3636@alpha.home.local>
References: <19005.1037854033@kao2.melbourne.sgi.com> <20021121050607.GA1554@mark.mielke.cc> <3DDCA7C9.9040501@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDCA7C9.9040501@netscape.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 10:30:49AM +0100, David Zaffiro wrote:
> I use -momit-leaf-frame-pointer for optimization in some own projects, 
> instead of the "-fomit-frame-pointer". For me, this results in better 
> codesize/speed compared to both "-fomit-frame-pointer" or no option at 
> all. Actually gcc-2.95 seems to support this feature as well, but it 
> never made it into the 2.95 docs... It makes debugging a lot easier too.
> 
> So anyone "caring to benchmark", could you please test the 
> "-momit-leaf-frame-pointer" option for x86 as well...

Well, I tried on a 2.4.18+patches with gcc 2.95.3. bzImage is :
538481 bytes with -fomit-frame-pointer
538510 bytes with no particular flag
542137 bytes with -momit-leaf-frame-pointer.

So -fomit-frame-pointer shows the same as other's observation, but in this
particular case, -momit-leaf-frame-pointer made a slightly bigger kernel.

Didn't have time to inspect all sections, though.

Cheers,
Willy

