Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUFWPXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUFWPXb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUFWPXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:23:31 -0400
Received: from mproxy.gmail.com ([216.239.56.245]:30403 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S261181AbUFWPXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:23:30 -0400
Message-ID: <7c07cd69040623082311234157@mail.gmail.com>
Date: Wed, 23 Jun 2004 20:53:29 +0530
From: abhijit <slashdev@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: do_gettimeofday( ) precision?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

the comment on top of do_gettimeofday( ) [arch/i386/kernel/time.c] says:

/*
 * This version of gettimeofday has microsecond resolution
 * and better than microsecond precision on fast x86 machines with TSC.
 */
void do_gettimeofday(struct timeval *tv)
{
...

but the code below limits usec to <= 1000000. so isn't the resolution
not limited to microsec even on TSC capable boxes? 

if one wants higher resolution (for timestamping etc.) whats the preferred
way?

thanks
abhijit
