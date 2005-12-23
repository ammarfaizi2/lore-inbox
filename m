Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbVLWPWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVLWPWY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 10:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbVLWPWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 10:22:24 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:15516 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964990AbVLWPWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 10:22:23 -0500
Date: Fri, 23 Dec 2005 18:22:11 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] New Year Acrypto release.
Message-ID: <20051223152211.GA13500@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 23 Dec 2005 18:22:11 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I'm pleased to announce new release of asynchronous crypto layer for
linux kernel 2.6.
Small changelog:

* Removed crypto load balancer thread.
* Eliminated main_crypto_dev.
* Removed unused session states.
* Simplified locking and reference counting.
* Simplified load balancing schema.
* Simple load balancer is part of acrypto module now.
* Added direct completion mode. If session's
  callback can be invoked in any context or
  if crypto provider can call   complete_session() from process context,
  one can set SESSION_DIRECT in session flags which will lead to callback
  invocation directly from  complete_session(), but not from workqueue.

* Here are dm-crypt port changes:
	o Reduced memory usage.
	o Use memory pools.
	o Removed several race conditions.
	o Code simplification.

More info can be found at the project's homepage:
http://tservice.net.ru/~s0mbre/old/?section=projects&item=acrypto

Tarball and patches against the latest tree can be found in archive:
http://tservice.net.ru/~s0mbre/archive/acrypto

-- 
	Evgeniy Polyakov
