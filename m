Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTJVGZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 02:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTJVGZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 02:25:27 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:930 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S263432AbTJVGZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 02:25:26 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Test8 suspend fails if laptop lid closed.
Date: Wed, 22 Oct 2003 01:22:27 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310220122.27837.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting.  Suspend to disk (echo -n disk > /sys/power/state) works just 
fine as long as I keep the laptop open until it powers down.  (I timed it, it 
takes 35 seconds by the way.  Over half of this is "freeing memory" without 
the hard drive light actually going...)

If I close the lid while it's busy suspend, it won't.  It'll almost suspend, 
but the CPU power will stay on, the fan will stay running, and the backlight 
will stay on even though the screen is otherwise black.  Only thing to do 
then is hold the power button down for ten seconds until it fully powers off, 
then reboot it.

It works reliably so far if I leave the lid open, and fails reliably with the 
lid closed before it's actually done suspending.  This is on a thinkpad 
iSeries 1200 something.  (Serial number starting with 1171 6xu, from which 
the model number can be googled for if it matters...)

Any ideas?

Rob
