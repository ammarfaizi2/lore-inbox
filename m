Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264940AbUELCXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbUELCXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 22:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUELCXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 22:23:55 -0400
Received: from mail.tpgi.com.au ([203.12.160.53]:22156 "EHLO mail5.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264940AbUELCXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 22:23:54 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Preempted by idle thread?
Date: Wed, 12 May 2004 12:23:26 +1000
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405121223.26115.ncunningham@linuxmail.org>
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I've been seeing some funny bad_scheduling_while_atomic messages that might be 
my own fault (they only occur after suspending). The funny thing, though, is 
that they are all the same, and show a calling chain:

schedule_tail -> preempt_schedule -> cpu_idle

Am I misunderstanding this, or is a thread being preempted by cpu_idle? If 
that is the case, real work shouldn't be preempted to idle, should it?

Nigel

