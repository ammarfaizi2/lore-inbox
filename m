Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTEHRDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 13:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTEHRDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 13:03:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:27014 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261893AbTEHRD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 13:03:29 -0400
Date: Thu, 8 May 2003 10:12:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: top stack (l)users for 2.5.69
Message-Id: <20030508101248.13be1f4c.rddunlap@osdl.org>
In-Reply-To: <20030508171042.V626@nightmaster.csn.tu-chemnitz.de>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
	<Pine.LNX.4.53.0305070933450.11740@chaos>
	<1052332566.752437@palladium.transmeta.com>
	<3EB95BD7.8060700@pobox.com>
	<20030507133856.02748f4e.rddunlap@osdl.org>
	<20030508171042.V626@nightmaster.csn.tu-chemnitz.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 May 2003 17:10:42 +0200 Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de> wrote:

| On Wed, May 07, 2003 at 01:38:56PM -0700, Randy Dunlap wrote:
| > I've written a few of the stack reduction patches.  Lots of ioctl functions
| > need work, so gcc handling it better would be good to have.
| > 
| > I have mostly used kmalloc/kfree, but using automatic variables is certainly
| > cleaner to write (code).  One of the patches that I did just made each ioctl
| > cmd call a separate function, and then each separate function was able to use
| > automatic variables on the stack instead of kmalloc/kfree.  I prefer this
| > method when it's feasible (and until gcc can handle these cases).
| 
| Wouldn't be a explicit union a better solution for the
| switch-statement-issue? 
| 
| That way you still can use stack, are using even less of it and
| have still all cases in place.

Sure, that's a good solution too.  Better one is the gcc solution.

--
~Randy
