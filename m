Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWHTVup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWHTVup (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 17:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWHTVup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 17:50:45 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:63616 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751193AbWHTVup
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 17:50:45 -0400
Date: Sun, 20 Aug 2006 23:47:27 +0200
To: thunder7@xs4all.nl
Cc: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@suse.de>,
       john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1 - time moving at 3x speed, fix confirmed
Message-ID: <20060820214727.GA4157@aitel.hist.no>
References: <20060813012454.f1d52189.akpm@osdl.org> <200608181134.02427.ak@suse.de> <44E588AB.3050900@aitel.hist.no> <200608181255.46999.ak@suse.de> <20060819105031.GA3190@aitel.hist.no> <Pine.LNX.4.64.0608201859130.6762@scrub.home> <20060820175128.GA4217@amd64.of.nowhere> <Pine.LNX.4.64.0608202120180.6761@scrub.home> <20060820194244.GA3997@amd64.of.nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820194244.GA3997@amd64.of.nowhere>
User-Agent: Mutt/1.5.12-2006-07-14
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 09:42:44PM +0200, thunder7@xs4all.nl wrote:
> From: Roman Zippel <zippel@linux-m68k.org>
> Date: Sun, Aug 20, 2006 at 09:24:05PM +0200
> > 
> > Thanks for testing, it's a silly sign problem. gcc turned the divide into 
> > an unsigned one.
> > 
> > bye, Roman
> > 
> > Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

I can confirm that 2.6.18-rc4-mm2 with this fix keeps time correctly.
2.6.18-rc4-mm2 without it has the 3x time problem, and 
produce the following debug output:

3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
u: 3538559.870999, 0.0000
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 1804.120 MHz processor.
.
.
.
3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
u: 3538559.870999, 0.0000
3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
u: 3538559.870999, 0.0000
3b9aca0000000000,d2ea237f00000000,d2ea237f00000000,35fe7fdef9db22
u: 3538559.870999, 0.0000

Helge Hafting
