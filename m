Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbUDSPxy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264517AbUDSPxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:53:54 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:33299 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S264515AbUDSPxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:53:50 -0400
Date: Mon, 19 Apr 2004 17:53:46 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>
Subject: [somewhat OT] binary modules agaaaain
Message-ID: <Pine.LNX.4.33.0404191651300.1869-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

I came across an idea, how Linux could allow binary modules, still having
reasonable control over them.

I am not advocating for binary modules, nor I am trying to make their life
harder, this is just an idea how it could be done.

I'll try to make it short, details may be discussed later, if any interest
arises.

A binary module is "considered good" if

1) It is accompanied by a "suitably licensed" (GPL-compatible) open-source
   glue-module.

2) The sourced used to compile the binary part do not access any of the
   kernel functionalities directly. Which means:
	a) they don't (need to) include any kernel header-files
	b) they don't access any kernel objects or methods directly
	c) all interfacing to the kernel goes over the glue module and the
	   interface is _purely functional_ - no macros, no inlines.

With this restrictions those "good" binary modules could be debugged, run
in a sandbox... The question remains if anybody will want to debug them:-)

Again - no advocating, just in case anyone find it useful / worthy.

Regards
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

