Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbULOSU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbULOSU5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbULOSU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:20:57 -0500
Received: from ns1.digitalpath.net ([65.164.104.5]:16582 "HELO
	mail.digitalpath.net") by vger.kernel.org with SMTP id S262433AbULOSUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:20:31 -0500
Date: Wed, 15 Dec 2004 10:19:44 -0800
From: Ray Van Dolson <rayvd@digitalpath.net>
To: linux-kernel@vger.kernel.org
Subject: unregister_netdevice: waiting for ppp546 to become free. Usage count = 1 (using tbf)
Message-ID: <20041215181944.GA4267@digitalpath.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Been seeing this problem from time to time--

After running /sbin/reboot the following message (or similar) loops
continuously and the only way to recover is to hard reboot the system.

unregister_netdevice: waiting for ppp546 to become free. Usage count = 1

We are using "tc" to do traffic shaping with the tbf (tocket bucket
filter).  Kernel is 2.6.9.

I found the following which appears to be similar:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109317866203856&w=2

Except that it relates to cbq specifically.  Could there be an issue with
the tbf code as well?

Ray
