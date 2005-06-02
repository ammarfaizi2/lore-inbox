Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVFBBpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVFBBpp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 21:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVFBBpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 21:45:45 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:45485 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261560AbVFBBpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 21:45:39 -0400
Subject: Re: Freezer Patches.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1117672513.19020.103.camel@gaston>
References: <1117629212.10328.26.camel@localhost>
	 <20050601130205.GA1940@openzaurus.ucw.cz>
	 <1117663709.13830.34.camel@localhost> <20050601223101.GD11163@elf.ucw.cz>
	 <1117665934.19020.94.camel@gaston>  <20050601230235.GF11163@elf.ucw.cz>
	 <1117672513.19020.103.camel@gaston>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1117676819.10888.109.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 02 Jun 2005 11:46:59 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-06-02 at 10:35, Benjamin Herrenschmidt wrote:
> > I agree that sync() is nice to have, but I'm not going to slow down
> > fork/exit for it. And besides, sys_sync() just before suspend works
> > just fine.
> 
> Yes, that's why I put it in my pre-freeze :)
> 
> I'll see about making my pre/post freeze stuff (APM emu + sync basically
> now) generic to avoid the callbacks.

Ummm. Don't do it if kthreads are already frozen. You'll deadlock against kjournald.

Regards,

Nigel

