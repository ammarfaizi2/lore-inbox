Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbUEBAg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbUEBAg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 20:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUEBAg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 20:36:59 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:41602 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262810AbUEBAg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 20:36:57 -0400
Date: Sun, 2 May 2004 02:36:50 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Chris Wedgwood <cw@f00f.org>
Cc: koke@amedias.org, linux-kernel@vger.kernel.org,
       Andries Brouwer <aeb@cwi.nl>
Subject: Re: strange delays on console logouts (tty != 1)
Message-ID: <20040502003650.GB4707@vana.vc.cvut.cz>
References: <20040430195351.GA1837@amedias.org> <20040501214617.GA6446@taniwha.stupidest.org> <20040501232448.GA4707@vana.vc.cvut.cz> <20040501234444.GA24120@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040501234444.GA24120@taniwha.stupidest.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 04:44:44PM -0700, Chris Wedgwood wrote:
> On Sun, May 02, 2004 at 01:24:48AM +0200, Petr Vandrovec wrote:
> 
> > I do not think that it is init...
> 
> No, it's not.

Though it would be nice to be able to strace init too...

> > (3) when you have bad luck then scheduled hangup work runs AFTER
> > newly created agetty calls VT_OPENQRY, and you get an error that
> > ttyX is already in use...
> 
> Unless I misunderstand you, I'm not conviced... it get tty's 'stuck',
> they never come right even after hours or days.

It is strange. After logout it always comes up after 10 seconds delay in first
agetty run expires. Only on first start some of them need more than one attempt
to come up.

Do not you start some multithreaded daemons from shell which gets later
'stuck'? Maybe that controlling terminal handling is not 100% yet. Do not
some daemons "randomly" disappear since you use vhangup in agetty? ;-) AFAIK
controlling terminal is not available through /proc :-(
						Best regards,
							Petr Vandrovec

