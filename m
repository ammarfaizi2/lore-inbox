Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbTCFAb5>; Wed, 5 Mar 2003 19:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267104AbTCFAb5>; Wed, 5 Mar 2003 19:31:57 -0500
Received: from ns.suse.de ([213.95.15.193]:27400 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267089AbTCFAb4>;
	Wed, 5 Mar 2003 19:31:56 -0500
Date: Thu, 6 Mar 2003 01:42:27 +0100
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.64
Message-ID: <20030306014227.B22857@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303041944390.3122-100000@home.transmeta.com> <20030305143608.A24878@infradead.org> <20030305181927.C20788@suse.de> <1046912796.15950.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1046912796.15950.27.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Mar 06, 2003 at 01:06:37AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 01:06:37AM +0000, Alan Cox wrote:

 > > Only the bits that did the module locking crap, which
 > > is unnecessary afaics.  If you look at the files touched,
 > > there's still nowayout used in the other functions.
 > 
 > You need to lock the module in memory in the nowayout case
 > Otherwise the module can be unloaded (which is ok), and then
 > reloaded (which is not).
 > 
 > So yes, you broke NOWAYOUT. Its a bit subtle and under
 > documented I admit.

Bugger. Ok, I'll add that to the TODO.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
