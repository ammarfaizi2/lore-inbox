Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbTKQTkj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 14:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTKQTkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 14:40:39 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:37281 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263666AbTKQTkh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 14:40:37 -0500
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Ronny V. Vindenes" <s864@ii.uib.no>, lkml <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>
In-Reply-To: <20031117113650.67968a26.akpm@osdl.org>
References: <1069071092.3238.5.camel@localhost.localdomain>
	 <20031117113650.67968a26.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1069097751.11437.1941.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Nov 2003 11:35:51 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-17 at 11:36, Andrew Morton wrote:
> "Ronny V. Vindenes" <s864@ii.uib.no> wrote:
> > I've found that neither linus.patch nor
> > context-switch-accounting-fix.patch is causing the problem, but rather
> > acpi-pm-timer-fixes.patch & acpi-pm-timer.patch
> > 
> > With these applied my cpu (athlon64) is detected as 0.0Mhz, bogomips
> > drops to 50% and anything cpu intensive destroys interactivity. Revert
> > them and performance is back at -mm2 level.
> 
> ah hah.  Thank you!
> 
> Probably the interactivity problems are due to the CPU scheduler thinking
> that the CPU runs at 0Hz.  If we can work out why the PM timer patch has
> broken the CPU clock speed detection then all should be well.

Hrmm. I'll look into this. 

thanks
-john




