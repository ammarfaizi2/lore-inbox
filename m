Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWAFQSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWAFQSh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbWAFQSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:18:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41227 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751581AbWAFQSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:18:36 -0500
Date: Fri, 6 Jan 2006 17:18:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] UML - Prevent MODE_SKAS=n and MODE_TT=n
Message-ID: <20060106161831.GH12131@stusta.de>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org> <20060104152433.7304ec75.akpm@osdl.org> <20060105022129.GA13183@ccure.user-mode-linux.org> <20060106124438.GB12131@stusta.de> <20060106163948.GA4340@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106163948.GA4340@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 11:39:48AM -0500, Jeff Dike wrote:
> On Fri, Jan 06, 2006 at 01:44:38PM +0100, Adrian Bunk wrote:
> > If MODE_TT=n, MODE_SKAS must be y.
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Great.  Now, how do you simultaneously implement 
> 	If MODE_SKAS=n, MODE_TT must be y.

That is already implemented in my patch:

MODE_TT=n forces MODE_SKAS=y.
MODE_TT=y allows any setting of MODE_SKAS.

MODE_SKAS=n is therefore impossible if MODE_TT=n.

> 				Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

