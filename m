Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTIURrz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 13:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbTIURrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 13:47:55 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:41077 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262497AbTIURry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 13:47:54 -0400
Date: Sun, 21 Sep 2003 18:47:31 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kronos <kronos@kronoz.cjb.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix Athlon MCA
Message-ID: <20030921174731.GA891@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Kronos <kronos@kronoz.cjb.net>,
	linux-kernel@vger.kernel.org
References: <20030921143934.GA1867@dreamland.darkstar.lan> <Pine.LNX.4.44.0309211034080.11614-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309211034080.11614-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 10:39:26AM -0700, Linus Torvalds wrote:

 > > This messages go away if I revert cset 1.1119.9.1. AFAIK you were trying
 > > to decrease the logging level. After reading IA32 Architecture Software 
 > > Developers Manual, vol3 - chapter 14.5 "Machine-Check Initialization" I 
 > > think that the right way to do it is this:
 > 
 > Why not just handling the (different) 0-based case in front of the loop: 
 > 
 > 	/* Clear status for MC index 0 separately, we don't touch CTL. */
 > 	wrmsr (MSR_IA32_MC0_STATUS, 0x0, 0x0);
 > 
 > and leave the loop 1-based.
 > 
 > Dave, up to you..

yeah, I prefer that way just for the added comment outside the loop.
expanding it to mention "some athlons don't work with bank 0 enabled"
would be a nice finishing touch.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
