Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVAEBJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVAEBJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVAEBJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:09:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:15031 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262176AbVAEBGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:06:21 -0500
Subject: Re: Very high load on P4 machines with 2.4.28
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicholas Berry <nikberry@med.umich.edu>
Cc: grendel@caudium.net, willy@w.ods.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <s1dad55b.011@med-gwia-02a.med.umich.edu>
References: <s1dad55b.011@med-gwia-02a.med.umich.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104879448.17176.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 00:02:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-04 at 22:41, Nicholas Berry wrote:
> Indeed. AIX (sorry) 5.3 on POWER5 explicitly disables SMT (IBM
> hyperthreading) if the load doesn't warrant it.
> 
> (Now how about that for Linux?) :)

It would be very nice to do but AFAIK no current processor with
hypedthreading lets you do dynamic disabling. We do try and land tasks
on the real processors before other SMT threads and to leave the other
threads idle. I'm not sure we could do much more unless flipping the
cache control bits on packages when idle is a win (which I doubt)

