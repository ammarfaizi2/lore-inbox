Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264081AbTDOCB3 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 22:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbTDOCB3 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 22:01:29 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:18902 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264081AbTDOCB2 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 22:01:28 -0400
Date: Tue, 15 Apr 2003 03:12:50 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@infradead.org>
Subject: Re: [FBCON] Could be called outside of a process context. This fixes that.
Message-ID: <20030415021242.GA2054@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	James Simmons <jsimmons@infradead.org>
References: <200304141829.h3EITgZF028370@hera.kernel.org> <20030414185326.1fdf2e01.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414185326.1fdf2e01.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 06:53:26PM -0700, Andrew Morton wrote:
 > > ChangeSet 1.981, 2003/03/25 10:21:46-08:00, jsimmons@maxwell.earthlink.net
 > > 	[FBCON] Could be called outside of a process context. This fixes that.
 > > 
 > 
 > GFP_ATOMIC memory allocations can and will return NULL when the system is
 > under load.  The driver _has_ to check for this, and cope with it.

James fixed this up in 1.982, when he changed things over to use workqueues.

		Dave

