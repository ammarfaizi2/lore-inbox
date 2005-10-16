Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVJPHqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVJPHqb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 03:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVJPHqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 03:46:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:9648 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751303AbVJPHqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 03:46:31 -0400
Date: Sun, 16 Oct 2005 08:46:26 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] highest_possible_processor_id() has to be a macro
Message-ID: <20051016074626.GC7992@ftp.linux.org.uk>
References: <20051015235112.GA7992@ftp.linux.org.uk> <20051016.001649.94729039.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051016.001649.94729039.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2005 at 12:16:49AM -0700, David S. Miller wrote:
> From: Al Viro <viro@ftp.linux.org.uk>
> Date: Sun, 16 Oct 2005 00:51:12 +0100
> 
> > 	... otherwise, things like alpha and sparc64 break and break
> > badly.  They define cpu_possible_map to something else in smp.h
> > *AFTER* having included cpumask.h.
> 
> So ugly...
> 
> But, it's the best fix for now.
> 
> Longer term we might want to make an asm/cpumask.h that can
> help allow the platforms to cleanly say "well, mask X is
> equivalent to Y, so only instantiate X and define Y to X"

Indeed, but playing with moving stuff from smp.h is definitely post-2.6.14
fodder...
