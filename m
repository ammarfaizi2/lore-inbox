Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264840AbTFLOom (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 10:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264841AbTFLOom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 10:44:42 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:10408 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264840AbTFLOol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 10:44:41 -0400
Date: Thu, 12 Jun 2003 15:58:14 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: open(.. O_DIRECT ..) difference in between Linux and FreeBSD ..
Message-ID: <20030612145814.GB14795@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andries Brouwer <aebr@win.tue.nl>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	linux-kernel@vger.kernel.org
References: <20030612111437.GE28900@mea-ext.zmailer.org> <20030612151704.A2588@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612151704.A2588@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 03:17:04PM +0200, Andries Brouwer wrote:
 >               Transfer sizes, and the alignment  of  user  buffer
 >               and  file offset must all be multiples of the logi-
 >               cal block size of the file system.

Just to confirm something that I wrote in the post-halloween-2.5 doc,
that doesn't tally with this..

- The size and alignment of O_DIRECT file IO requests now matches that
  of the device, not the filesystem.  Typically this means that
  you can perform O_DIRECT IO with 512-byte granularity rather than 4k.

Is this a case of the man pages not following 2.5 yet, or is this
incorrect ?

		Dave

