Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTF2UWU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTF2UWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:22:19 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33422
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264432AbTF2UWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:22:15 -0400
Subject: Re: 2.5.73-mm2 - odd audio problem, bad intel8x0/ac97 clocking.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davej@codemonkey.org.uk
In-Reply-To: <200306291810.h5TIApEA002032@turing-police.cc.vt.edu>
References: <200306282131.h5SLVjGk001833@turing-police.cc.vt.edu>
	 <20030628171036.4af51e08.akpm@digeo.com>
	 <200306291810.h5TIApEA002032@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056918812.16255.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jun 2003 21:33:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-29 at 19:10, Valdis.Kletnieks@vt.edu wrote:
> > It could be that do_gettimeofday() has gone silly.  Could you
> > add this patch and see what it says?
> 
> Woo woo.  Good catch, Andrew.  It says:
> 
> intel8x0_measure_ac97_clock: measured 39909 usecs
> 
> Hmm.. wonder why it's 40K rather than the expected 50K...

Lots of laptops clock the i810 audio off an existing clock and software
fix up the difference. Saves components.


