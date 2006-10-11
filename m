Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030655AbWJKGLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030655AbWJKGLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030647AbWJKGLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:11:11 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:17266 "EHLO
	asav00.insightbb.com") by vger.kernel.org with ESMTP
	id S1030655AbWJKGLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:11:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CAFonLEWMCCw
Message-Id: <20061011060138.920913139.dtor@insightbb.com>
Date: Wed, 11 Oct 2006 02:01:38 -0400
From: Dmitry Torokhov <dtor@insightbb.com>
To: linux-pm@lists.osdl.org
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, pavel@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: [RFC/PATCH 0/3] Integrating struct class_device into power management framework
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches integrate class devices into common PM framework.
Classes can define 2 new methods: pause() and restart() that will be
called at suspend and resume time respectively. This will ease hardware
driver's tasks at suspend and resume time by moving common code into
classes.

The advantages of integrating class_device over moving to struct device:

 - no need to reshuffle entire kernel, subsystems can be converted
   one by one without a flag day;
 - struct device will not become a kitchen sink.

--
Dmitry
