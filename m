Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUE2WXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUE2WXT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 18:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUE2WXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 18:23:19 -0400
Received: from gprs214-14.eurotel.cz ([160.218.214.14]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261162AbUE2WXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 18:23:18 -0400
Date: Sun, 30 May 2004 00:23:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Stuart Young <cef-lkml@optusnet.com.au>, linux-kernel@vger.kernel.org,
       Rob Landley <rob@landley.net>, seife@suse.de
Subject: Re: swappiness=0 makes software suspend fail.
Message-ID: <20040529222308.GA1535@elf.ucw.cz>
References: <200405280000.56742.rob@landley.net> <20040528215642.GA927@elf.ucw.cz> <200405291905.20925.cef-lkml@optusnet.com.au> <40B85024.2040505@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B85024.2040505@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Stefan, we may want to do echo 100 > /proc/sys/vm/swappiness in
> >>suspend script...
> >
> >
> >Really, you should save that value somewhere and then restore it after 
> >suspend, or those people who do use /proc/sys/vm/swappiness will likely 
> >complain about it (ie: me).
> 
> Yes. This doesn't need to be done by the script. I'll change suspend2 so it 
> saves and restores the value.

That's wrong solution.

Right solution is to make sure that shrink_all_memory() works, no
matter how swappiness is set.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
