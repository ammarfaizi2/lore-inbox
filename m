Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbUK0CxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbUK0CxQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbUK0CEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:04:43 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262995AbUKZTiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:15 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16806.1163.601015.670054@robur.slu.se>
Date: Thu, 25 Nov 2004 17:12:59 +0100
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, Robert.Olsson@data.slu.se
Subject: CONFIG_TULIP_NAPI_HW_MITIGATION latency question.
In-Reply-To: <Pine.LNX.4.61.0411231242090.3740@p500>
References: <Pine.LNX.4.61.0411231242090.3740@p500>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Justin Piszcz writes:
 > "at the cost of a small latency"
 > 
 > How much additional latency is added with this option enabled?
 > 
 > 5ms? 10ms?
 > 
 > -> Use Interrupt Mitigation
 >    x CONFIG_TULIP_NAPI_HW_MITIGATION:
 >    x Use HW to reduce RX interrupts. Not strict necessary since NAPI 
 > reduces RX interrupts but itself. Although this reduces RX interrupts even at 
 > low levels traffic at the cost of a small latency. 
 > x
 >    x If in doubt, say Y. 

 Hello!

 It's in usec and the tulip only enables this latency when it's needed it
 really tries to keep latency down. 

 It has three steeps of input control.

 Low rate:     No driver latency. No interrupt delay at all.
 Medium rate:  Samll driver latency.
 High rate:    Polling via ->poll

						--ro
