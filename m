Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbTFLNDV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 09:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264779AbTFLNDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 09:03:21 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:50440 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264777AbTFLNDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 09:03:20 -0400
Date: Thu, 12 Jun 2003 15:17:04 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: open(.. O_DIRECT ..) difference in between Linux and FreeBSD ..
Message-ID: <20030612151704.A2588@pclin040.win.tue.nl>
References: <20030612111437.GE28900@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030612111437.GE28900@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Thu, Jun 12, 2003 at 02:14:37PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 02:14:37PM +0300, Matti Aarnio wrote:

> I have been debugging long and hard a thing where IO is done
> with O_DIRECT flag applied to open(2).
> 
> Unlike Linux, FreeBSD (where this flag originates, apparently) does
> _not_ require that read()/write() happens from page aligned memory
> areas, and/or be of page-size multiples in size.
> 
> This needs at least wording in  open(2) man-page

Ha Matti, I was going to suggest you to send a patch to the man page
maintainer, but maybe the wording you ask for is there already and
you just have some outdated version of the manpages?

Andries

       O_DIRECT
              Try to minimize cache effects of  the  I/O  to  and
              from  this file.  In general this will degrade per-
              formance, but it is useful in  special  situations,
              such  as  when  applications  do their own caching.
              File  I/O  is  done  directly  to/from  user  space
              buffers.  The I/O is synchronous, i.e., at the com-
              pletion of the read(2)  or  write(2)  system  call,
              data   is  guaranteed  to  have  been  transferred.
              Transfer sizes, and the alignment  of  user  buffer
              and  file offset must all be multiples of the logi-
              cal block size of the file system.

