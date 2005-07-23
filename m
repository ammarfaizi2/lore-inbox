Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVGWTd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVGWTd2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 15:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVGWTd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 15:33:27 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:26007 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261875AbVGWTba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 15:31:30 -0400
Subject: Re: [PATCH] reset VGA adapters via BIOS on resume...
	(non-fbdev/con)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
In-Reply-To: <E1Dw6lc-0007IU-00@chiark.greenend.org.uk>
References: <Pine.LNX.4.58.0507221942540.5475@skynet>
	 <E1Dw6lc-0007IU-00@chiark.greenend.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 23 Jul 2005 20:55:37 +0100
Message-Id: <1122148537.27629.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-07-23 at 00:17 +0100, Matthew Garrett wrote:
> Dave Airlie <airlied@linux.ie> wrote:
> 
> > 	At OLS at lot of people were giving out about cards not resuming,
> > so using a patch from Michael Marineau and help from lots of people
> > sitting around in a circle at OLS I've gotten a patch that restores video
> > on my laptop by going into real mode and re-posting the BIOS during
> > resume,
> 
> On laptops, the code at c000:0003 may jump to BIOS code that isn't
> present after system boot. In userspace, this isn't too much of a
> problem - the userspace code tends to just fall over rather than hanging
> the machine. What happens if the kernel hits illegal or inappropriate
> code on resume?

For Intel at least the recommendation is to use the BIOS "save
mode"/"restore mode" interface.

