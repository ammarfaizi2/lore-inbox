Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUJHTIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUJHTIy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 15:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270032AbUJHSP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:15:29 -0400
Received: from smtp.mitel.com ([216.191.234.102]:57058 "EHLO smtp.mitel.com")
	by vger.kernel.org with ESMTP id S270073AbUJHRpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:45:11 -0400
Date: Fri, 8 Oct 2004 13:45:10 -0400
From: michael_soulier@mitel.com
To: linux-kernel@vger.kernel.org
Cc: john_fodor@mitel.com
Subject: wait_event and preemption in 2.6
Message-ID: <20041008174510.GJ30977@e-smith.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, john_fodor@mitel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am sending this on behalf of a coworker who is unfortunate enough to
be using a crappy email client. We are not subscribed to the mailing
list, so please include us in your replies. 

---quote---
Dear kernel folks,

I'm writing a device driver for PPC Linux and I'm using wait_event. It
seems to me that there is a potential race condition in wait_event when
preemption is turned on (2.6 kernel).

The scenario goes something like this: After the waiting process is
woken up and returns from schedule it goes to the top of the loop and
prepares to wait again (despite the condition being true). Then it will
check the condition and break out of the loop. But what if in-kernel
preemption occurs while it's doing that and another process is
immediately scheduled to run? Does the process sleep forever? Assume
that the event (say interrupt) that caused the original wakeup is a one
shot.

I'm probably missing something. I've googled for an answer and asked
some of my Linux friends but it's not clear. Thanks for any replies.
Please cc me.

John
---end---

Thank you,
Mike

--
Michael P. Soulier <michael_soulier@mitel.com>
6000/6010/60* Development, Mitel Networks Corporation
"...the word HACK is used as a verb to indicate a massive amount of nerd-like
effort." -Harley Hahn, A Student's Guide to Unix
