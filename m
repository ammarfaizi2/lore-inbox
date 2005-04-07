Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVDGXXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVDGXXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 19:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVDGXWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 19:22:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:10719 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262613AbVDGXUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 19:20:22 -0400
Subject: Re: [PATCH] radeonfb: (#2)  Implement proper workarounds for PLL
	accesses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <jevf6y6uzo.fsf@sykes.suse.de>
References: <1110519743.5810.13.camel@gaston>
	 <1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	 <1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>
	 <1112827655.9518.194.camel@gaston> <jehdii8hjk.fsf@sykes.suse.de>
	 <1112914051.9518.306.camel@gaston>  <jevf6y6uzo.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 09:19:13 +1000
Message-Id: <1112915953.9517.329.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 01:13 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Can you cound how many times radeonfb_set_par is called and dump your
> > "counter" at the beginning and end of each of these calls ?
> 
> Switch from X to console:
> 
> kernel: radeonfb_set_par
> kernel: radeon_pll_errata_after_data
> last message repeated 774 times
> kernel: radeonfb_set_par
> kernel: radeon_pll_errata_after_data
> last message repeated 918 times

Ok, so somebody is calling set_par twice ... I suppose I know why but
it's not a very nice thing to do. Still, it doesn't explain why there
are so many calls to the errata. Please read my other email and try to
figure out where those big numbers come from...

Ben.


