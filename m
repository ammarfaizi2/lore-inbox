Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965270AbVLRUcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbVLRUcf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 15:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965275AbVLRUcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 15:32:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:51420 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965270AbVLRUce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 15:32:34 -0500
Subject: USB rejecting sleep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 07:27:21 +1100
Message-Id: <1134937642.6102.85.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Alan !

What exactly changed in the recent USB stacks that is causing it to
abort system suspend much more often ? I'm getting lots of user reports
with 2.6.15-rc5 saying that they can't put their internal laptops to
sleep, apparently because a driver doesn't have a suspend method
(internal bluetooth in this case).

It's never been mandatory so far for all drivers of all connected
devices to have a suspend method... didn't we decide back then that
disconneting those was the right way to go ?

Any reason we are rejecting the sleep process for these currently ? A
locking issue that makes disconnecting not yet feasible ? What changed
from the previous version where that worked ?

Cheers,
Ben.

