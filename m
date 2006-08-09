Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWHIXJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWHIXJA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 19:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWHIXJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 19:09:00 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:2499 "EHLO
	dhcp119.mvista.com") by vger.kernel.org with ESMTP id S1751423AbWHIXJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 19:09:00 -0400
Date: Wed, 9 Aug 2006 16:08:57 -0700
Message-Id: <200608092308.k79N8vZg028304@dhcp119.mvista.com>
Subject: [PATCH 0/2] posix-timers: Fix wrong behaviour of clock_nanosleep()
From: toyoa@mvista.com
To: george@wildturkeyranch.net
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes 2 problems in clock_nanosleep(). One is clock_nanosleep()
does not return the remaining time and returns wrong errno to user in compatibility
mode, if it is interrupted by a signal and restarts sleeping.
The other one is posix_cpu_nsleep() does not handle the flags argument properly.

Sincerely,
Toyo Abe <toyoa@mvista.com>
