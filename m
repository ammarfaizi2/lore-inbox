Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTLPPnG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 10:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTLPPnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 10:43:06 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:52709 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261868AbTLPPnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 10:43:04 -0500
Date: Tue, 16 Dec 2003 10:18:38 -0500
From: Ben Collins <bcollins@debian.org>
To: Luca <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test11] IEEE1394: sleeping function called from invalid context
Message-ID: <20031216151838.GO7308@phunnypharm.org>
References: <20031216153844.GA2806@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031216153844.GA2806@dreamland.darkstar.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This time highlevel_remove_host takes a rwlock and calls nodemgr_remove_host
> and then we call wait_for_completion with a lock held.
> 
> Not sure about the fix... maybe hl_drivers list should be protected with a 
> rw_semaphore instead of a rwlock.

I've already fixed this in the ieee1394 repo. Pretty extensive changes,
so don't count on it for 2.6.0.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
