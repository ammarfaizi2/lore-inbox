Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264072AbUE1V5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbUE1V5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbUE1V5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:57:30 -0400
Received: from gprs214-232.eurotel.cz ([160.218.214.232]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264072AbUE1V4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:56:51 -0400
Date: Fri, 28 May 2004 23:56:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>, seife@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: swappiness=0 makes software suspend fail.
Message-ID: <20040528215642.GA927@elf.ucw.cz>
References: <200405280000.56742.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405280000.56742.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> With swappiness at the default (60), software suspend frees all the memory it 
> needs.  With swappiness at 0, software suspend basically doesn't free any 
> memory, and the suspend gets aborted.
> 
> Just thought I'd mention it.  Tried on 2.6.6...

Uh, yes, right.

That explains why some people see bad problems I could not
reproduce. Thanks a lot.

Stefan, we may want to do echo 100 > /proc/sys/vm/swappiness in
suspend script...

									Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
