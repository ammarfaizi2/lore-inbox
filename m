Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUDJNfu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 09:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUDJNft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 09:35:49 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:41233 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262009AbUDJNfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 09:35:48 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: LKML <linux-kernel@vger.kernel.org>
Subject: hangcheck watchdog triggers if clock=pit. Missing code in monotonic_clock_pit()?
Date: Sat, 10 Apr 2004 16:35:37 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404101635.37401.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.6.5/arch/i386/kernel/time.c:
====================================
/* monotonic_clock(): returns # of nanoseconds passed since time_init()
 *              Note: This function is required to return accurate
 *              time even in the absence of multiple timer ticks.
 */
unsigned long long monotonic_clock(void)
{
        return cur_timer->monotonic_clock();
}

linux-2.6.5/arch/i386/kernel/timers/timer_pit.c:
================================================
static unsigned long long monotonic_clock_pit(void)
{
        return 0;
}
--
vda

