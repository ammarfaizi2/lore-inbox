Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbTKMSDe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 13:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264360AbTKMSDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 13:03:34 -0500
Received: from zok.sgi.com ([204.94.215.101]:6861 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261838AbTKMSDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 13:03:33 -0500
Date: Thu, 13 Nov 2003 10:02:56 -0800
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_file version of /proc/interrupts
Message-ID: <20031113180255.GA27893@sgi.com>
Mail-Followup-To: Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org
References: <20031113173626.12557.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031113173626.12557.qmail@lwn.net>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 10:36:26AM -0700, Jonathan Corbet wrote:
> This version should scale to something over 300 processors, after which it
> will not be possible to fit even a single line of /proc/interrupts output
> into one page.  At that point, if this output format is even remotely
> useful, some sort of iterator which tracks interrupt and CPU numbers will
> be needed.

I assume you're talking about overflowing a 4k page?  If so, we might be
able to limp along with the small 300p limit for awhile on ia64 since
most people running large systems use at least a 16k page size.

Thanks,
Jesse
