Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbTGHLO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267166AbTGHLOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:14:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12268 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267186AbTGHLMX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:12:23 -0400
Date: Tue, 8 Jul 2003 12:26:58 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] parallel directory operations
Message-ID: <20030708112658.GJ23597@parcelfarce.linux.theplanet.co.uk>
References: <87wuetukpa.fsf@gw.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wuetukpa.fsf@gw.home.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 03:01:05PM +0000, Alex Tomas wrote:
> I would to like to see any comments/suggestions.

> dynamic locks. supports exclusive and shared locks. exclusive lock may
> be taken several times by first owner.

Yuck.  It spins, it sleeps, it can be acquired recursively by the same
process.  Ugly stuff.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
