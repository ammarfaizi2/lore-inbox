Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWC3Kg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWC3Kg5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWC3Kg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:36:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:23725 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932167AbWC3Kg4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:36:56 -0500
Date: Thu, 30 Mar 2006 11:36:52 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, bharata@in.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: dcache leak in 2.6.16-git8 II
Message-ID: <20060330103651.GY27946@ftp.linux.org.uk>
References: <200603270750.28174.ak@suse.de> <200603271822.28043.ak@suse.de> <20060327190027.24498e3a.akpm@osdl.org> <200603300026.59131.ak@suse.de> <20060330095048.GW27946@ftp.linux.org.uk> <20060330101256.GX27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330101256.GX27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, it allows even funnier stuff: instead of "I'd been allocated by <place>"
you can do "I'd passed through <place>".  E.g. if object has different states
you can slap slab_charge_here() in state transitions and /proc/slab_allocators
will count them separately, showing how many objects are in which state, etc.
