Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbTKQTg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 14:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTKQTg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 14:36:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:28138 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263611AbTKQTg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 14:36:27 -0500
Date: Mon, 17 Nov 2003 11:36:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Ronny V. Vindenes" <s864@ii.uib.no>
Cc: linux-kernel@vger.kernel.org, Dominik Brodowski <linux@brodo.de>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
Message-Id: <20031117113650.67968a26.akpm@osdl.org>
In-Reply-To: <1069071092.3238.5.camel@localhost.localdomain>
References: <1069071092.3238.5.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ronny V. Vindenes" <s864@ii.uib.no> wrote:
>
> > Your report has totally confused me.  Are you saying that the
> jerkiness is
> > caused by linus.patch?  Or not?  Pleas try again ;)
> > 
> 
> I've found that neither linus.patch nor
> context-switch-accounting-fix.patch is causing the problem, but rather
> acpi-pm-timer-fixes.patch & acpi-pm-timer.patch
> 
> With these applied my cpu (athlon64) is detected as 0.0Mhz, bogomips
> drops to 50% and anything cpu intensive destroys interactivity. Revert
> them and performance is back at -mm2 level.

ah hah.  Thank you!

Probably the interactivity problems are due to the CPU scheduler thinking
that the CPU runs at 0Hz.  If we can work out why the PM timer patch has
broken the CPU clock speed detection then all should be well.


