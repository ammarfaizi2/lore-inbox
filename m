Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbTCEXvH>; Wed, 5 Mar 2003 18:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267033AbTCEXvH>; Wed, 5 Mar 2003 18:51:07 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63908
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267029AbTCEXvG>; Wed, 5 Mar 2003 18:51:06 -0500
Subject: Re: Linux 2.5.64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030305181927.C20788@suse.de>
References: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com>
	 <20030305143608.A24878@infradead.org>  <20030305181927.C20788@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046912796.15950.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 06 Mar 2003 01:06:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-05 at 17:19, Dave Jones wrote:
> On Wed, Mar 05, 2003 at 02:36:09PM +0000, Christoph Hellwig wrote:
>  > >   o [WATCHDOG] Remove old unneeded borken module locking
>  > 
>  > You just removed the nowayout functionality..
> 
> Only the bits that did the module locking crap, which
> is unnecessary afaics.  If you look at the files touched,
> there's still nowayout used in the other functions.

You need to lock the module in memory in the nowayout case
Otherwise the module can be unloaded (which is ok), and then
reloaded (which is not).

So yes, you broke NOWAYOUT. Its a bit subtle and under
documented I admit.

