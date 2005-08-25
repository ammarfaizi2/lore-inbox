Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVHYBWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVHYBWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 21:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVHYBWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 21:22:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:424 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932466AbVHYBWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 21:22:23 -0400
Message-Id: <20050825012028.720597000@localhost.localdomain>
Date: Wed, 24 Aug 2005 18:20:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>
Subject: [PATCH 0/5] LSM hook updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is based on Kurt's original work.  The net effect is that
LSM hooks are called conditionally, and in all cases capabilities
provide the defaults.  I've done some basic performance testing, and
found nothing surprising.  I'm interested to see numbers from others
before I push this up.  These are against Linus' current git tree (they
will clash with the -mm tree).

 security/dummy.c         |  996 ----------------------------
 include/linux/security.h | 1665 ++++++++++++++++++++--------------------------- security/Makefile        |    9
 security/commoncap.c     |  160 ++--
 security/root_plug.c     |   14
 security/security.c      |   62 -
 6 files changed, 839 insertions(+), 2067 deletions(-)

thanks,
-chris
--
