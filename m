Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265646AbUABVYY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 16:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265647AbUABVYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 16:24:24 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:51954 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265646AbUABVYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 16:24:23 -0500
Date: Fri, 2 Jan 2004 13:24:17 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Elliott Bennett <lkml@dhtns.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: JFS resize=0 problem in 2.6.0
Message-ID: <20040102212417.GG1882@matchmail.com>
Mail-Followup-To: Elliott Bennett <lkml@dhtns.com>,
	linux-kernel@vger.kernel.org
References: <20031228153028.GB22247@faraday.dhtns.com> <20031229000503.GD1882@matchmail.com> <20040102201221.GA28116@faraday.dhtns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040102201221.GA28116@faraday.dhtns.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 03:12:21PM -0500, Elliott Bennett wrote:
> Soo...I would say that something is awry with the resizing of JFS
> filesystems.  My patch obviously doesn't fix everything, but at least
> makes resizing to fill available space *possible*. :)
> 
> The code surrounding my patch change treats the same variable (resize,
> which is a pointer to args[0].from) as a string, so it seems pretty
> obvious to me it should be comparing to '0'.

I would be careful of DM and MD RAID in 2.6.0.  There are some bugs flying
around mentioning XFS->DM->MD RAID, , but also reproducable with Ext3->DM.

So if you're using DM, you might want to do some extra consistancy checks in
your tests, and don't use it with important data.

