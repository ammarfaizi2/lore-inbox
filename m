Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269857AbUJGWVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269857AbUJGWVA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269856AbUJGWS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:18:59 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:47290 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S269857AbUJGWRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:17:48 -0400
Date: Thu, 7 Oct 2004 15:17:45 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mmap specification - was: ... select specification
Message-ID: <20041007221745.GA16597@taniwha.stupidest.org>
References: <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com> <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir> <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org> <001c01c4ac76$fb9fd190$161b14ac@boromir> <1097156727.31753.44.camel@localhost.localdomain> <001f01c4ac8b$35849710$161b14ac@boromir> <1097160628.31614.68.camel@localhost.localdomain> <20041007215834.GA7047@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007215834.GA7047@pclin040.win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 11:58:34PM +0200, Andries Brouwer wrote:

> [I read this as follows: If you mmap a file with MAP_SHARED and
> modify the memory at an address so far beyond EOF that it is not in
> a page containing stuff from the file, then you get a SIGBUS. --
> Linux does this.  Also, that if you modify the memory at an address
> beyond EOF, then the file is not modified. -- Again Linux does
> this.]

consider mmaping a 1-byte file ... you can modify bytes 0..4095.
bytes 1..4095 shouldn't be recorded to disk ideally

at one point one fs did actually store this data and it caused cpp
problems (it would expect to see zeroes and where it didn't it got
upset)
