Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267291AbSLKTaV>; Wed, 11 Dec 2002 14:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267293AbSLKTaV>; Wed, 11 Dec 2002 14:30:21 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:19467
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267291AbSLKTaU>; Wed, 11 Dec 2002 14:30:20 -0500
Subject: Re: Destroying processes
From: Robert Love <rml@tech9.net>
To: Justin Hibbits <jrh29@po.cwru.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021211193049.GH147@lothlorien.cwru.edu>
References: <20021211190132.GF147@lothlorien.cwru.edu>
	 <1039634515.833.57.camel@phantasy>
	 <20021211193049.GH147@lothlorien.cwru.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1039635486.832.86.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 14:38:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 14:30, Justin Hibbits wrote:

> Ok, thanks for clearing that up.  My reasoning for wanting this is because a CD
> I had mounted with cdfs was screwed up in the mount (file sizes were
> misreported, etc), and I couldn't umount it, even tho I could eject it with
> cdrecord -eject.  The umount process then went to sleep (with teh 'D' showing
> in ps/top), and I couldn't use that drive again until after a reboot.  That's
> when I got the idea that I should be able to destroy the process completely,
> annihilating everything with it, destroying any connections it has with the
> kernel, etc.  I guess it's a bad idea, given your statement :P

Yah you do not want to be able to kill that hung task.

At the same time, this is a cdfs so we DO want to fix that. I.e., while
it is unsafe and not clean to kill a sleeping task, you should never
need to.  So this bug should be fixed.

	Robert Love

