Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266726AbUFWVcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266726AbUFWVcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266696AbUFWV1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:27:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55780 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266729AbUFWVY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:24:59 -0400
Date: Wed, 23 Jun 2004 22:24:59 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: mikem@beardog.cca.cpqcorp.net
Cc: linux-kernel@vger.kernel.org, viro@www.linux.org.uk, bob.montgomery@hp.com
Subject: Re: problems with alloc_disk in genhd.c
Message-ID: <20040623212459.GK12308@parcelfarce.linux.theplanet.co.uk>
References: <20040623211829.GC16336@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623211829.GC16336@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 04:18:29PM -0500, mikem@beardog.cca.cpqcorp.net wrote:
> In the  ioctl we are doing
> 
>         /* count partitions 1 to 15 with sizes > 0 */
>         for(i=0; i <MAX_PART; i++) {

... followed by what?

Array of per-partition structures contains the data for partitions,
obviously.  And drivers have no damn business to ever touching it
directly, while we are at it.

BTW, take a look at the comment and loop following it.  And note
that you are doing 16 iterations in the loop, contrary to what
the comment above it says.
