Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUFYAVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUFYAVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 20:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265961AbUFYAVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 20:21:08 -0400
Received: from levante.wiggy.net ([195.85.225.139]:41696 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S264519AbUFYAU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 20:20:59 -0400
Date: Fri, 25 Jun 2004 02:20:57 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: sys_gettimeofday racy or not?
Message-ID: <20040625002057.GA3052@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This just happened to catch my eye and it's probably perfectly
valid, but if so please educate me on why it is. In kernel/time.c
sys_gettimeofday() there is this code:

        if (unlikely(tz != NULL)) {
                if (copy_to_user(tz, &sys_tz, sizeof(sys_tz)))
                        return -EFAULT;
        }

what prevents sys_tz from being changed while this code runs?

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
