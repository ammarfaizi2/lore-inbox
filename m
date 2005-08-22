Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVHVXCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVHVXCI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVHVXCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:02:07 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:20623 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751184AbVHVXCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:02:05 -0400
X-ORBL: [63.205.185.3]
Date: Sun, 21 Aug 2005 19:37:55 -0700
From: Chris Wedgwood <cw@f00f.org>
To: 7eggert@gmx.de
Cc: cHitman <samartsev@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH for changing of DVD speed via ioctl() call
Message-ID: <20050822023755.GA22851@taniwha.stupidest.org>
References: <4E0p1-3vc-23@gated-at.bofh.it> <E1E6vvy-0000hI-Hj@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1E6vvy-0000hI-Hj@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 09:56:45PM +0200, Bodo Eggert wrote:

> The parameter value should IMHO be a pointer to a struct {
>  unsigned long long maxspeed; // (with 0 being the magic max. value?)
>  int facility; /* 0=general speed, 2=general read, 4=read data,
>                   6=read audio, 8=read raw ... whatever is supported
>                   n+1 = s/read/write/ */
> }

Passing pointers inside ioctl's is horrible IMO and if we can avoid it
we should.  It's just asking for problems.
