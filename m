Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWHOWKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWHOWKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 18:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWHOWKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 18:10:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21937 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750745AbWHOWKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 18:10:47 -0400
Date: Tue, 15 Aug 2006 18:10:35 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: peculiar suspend/resume bug.
Message-ID: <20060815221035.GX7612@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a fun one.
- Get a dual core cpufreq aware laptop (Like say, a core-duo)
- Add a cpufreq monitor to gnome-panel. Configure it
  to watch the 2nd core.
- Suspend.
- Resume.

Watch the cpufreq monitor die horribly.

I believe this is because we take down the 2nd core at suspend
time with cpu hotplug, and for some reason we're scheduling
userspace before we bring that second core back up.

Anyone have any clues why this is happening?

		Dave

-- 
http://www.codemonkey.org.uk
