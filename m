Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVBHUIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVBHUIZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVBHUIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:08:25 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:38894 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261650AbVBHUHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:07:39 -0500
Date: Tue, 8 Feb 2005 12:07:35 -0800
From: Chris Wedgwood <cw@f00f.org>
To: jon ross <jonross@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM disk cache behavior.
Message-ID: <20050208200735.GA24094@taniwha.stupidest.org>
References: <e130a7170502080906596561d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e130a7170502080906596561d7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 12:06:14PM -0500, jon ross wrote:

> I have an app with a small fixed memory footprint that does a lot of
> random reads from a large file. I thought if I added more memory to
> the machine the VM would do more caching of the disk, but added
> memory does not seem to make any difference. I played with some of
> the params in /proc/sys/vm and none of them seem to have any effect.

If the file is much larger than your RAM size and your access really
are random, you're probably SOL as you will be seek/IO bound most of
the time.

How large is the 'large file' ?
