Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUAWP5H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266571AbUAWP5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:57:07 -0500
Received: from main.gmane.org ([80.91.224.249]:47244 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262784AbUAWP5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:57:05 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andres Salomon <dilinger@voxel.net>
Subject: rtl8180 status update
Date: Fri, 23 Jan 2004 10:57:00 -0500
Message-ID: <pan.2004.01.23.15.56.56.470549@voxel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I'm getting a lot of queries about the status of my rtl8180 driver,
I figured I'd post an update.  It's not currently in a usable state; I'm
working on 802.11 manage frames, to make the card able to
associate w/ an AP.  I haven't been able to figure out if the hardware has
any sort of support for wrapping frames (management or otherwise) with
PLCP and MAC headers, and/or whether there's a special tx register/ring
for sending out management frames.  As there's no common code for
constructing management frames (each wireless driver seems to implement
it), I'm currently working on constructing a probe packet (w/ PLCP and
MAC headers added), sending it out through the normal tx ring, and hoping
my AP is kind enough to respond.  If that works, I'll at least know that
my rx/tx handling code is correct; right now, I don't think I can test it
w/out associating.



