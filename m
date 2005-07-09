Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263029AbVGIB2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbVGIB2I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 21:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbVGIB2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 21:28:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20194 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263029AbVGIB0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 21:26:53 -0400
Date: Fri, 8 Jul 2005 18:24:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: Robert Love <rml@novell.com>, ttb@tentacle.dhs.org
Cc: linux-kernel@vger.kernel.org, linux-audit@redhat.com,
       David Woodhouse <dwmw2@infradead.org>,
       "Timothy R. Chavez" <tinytim@us.ibm.com>
Subject: [RFC/PATCH 0/2] fsnotify/inotify split
Message-ID: <20050709012436.GD19052@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following two patches simply split fsnotify from inotify.
There should be no functional change to inotify at all.  Perhaps the
split will help identify the interface bits that can easily converge
for inotify and audit.  They're completely untested...  I started with
inotify-45 in 2.6.13-rc2-mm1, and worked against base 2.6.13-rc2.

My first pass was trivial split, this is my second pass which moves
dnotify and inotify functionality out of fsnotify.h into their respective
corners.  I'm sure audit can at least use the hooks, and perhaps more
base inode watch functionality could be shared (at no cost to you! ;-)
moving forward.

thanks,
-chris
