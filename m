Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271083AbUJUXRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271083AbUJUXRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271080AbUJUXLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:11:33 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14572 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S271067AbUJUXHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:07:19 -0400
Subject: How is user space notified of CPU speed changes?
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Robert Love <rml@novell.com>
Content-Type: text/plain
Message-Id: <1098399709.4131.23.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 19:01:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This issue came up on the JACK (http://jackit.sf.net) mailing list. 
Google was not helpful so I ask here.

JACK needs to know the CPU speed, in order to calculate the DSP load
among other things.  It used to be a valid assumption that you could
calculate it on startup and it would not change.

Now with frequency scaling (apparently desktops do this as well as
laptops) this doesn't work anymore.  Is there a sane way for jackd to be
notified when the CPU speed changes?  Polling a file in /sys is not good
enough, the overhead is unacceptable and we need to know _now_.

Is this the kind of thing that would require the new kernel event
interface?

Lee

