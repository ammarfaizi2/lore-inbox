Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTFORuA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbTFORuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:50:00 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:49680 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262470AbTFORt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:49:59 -0400
Date: Sun, 15 Jun 2003 19:03:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, Brian Jackson <brian@mdrx.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: [PATCH] make cramfs look less hostile
Message-ID: <20030615190349.A21931@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	linux-kernel@vger.kernel.org, Brian Jackson <brian@mdrx.com>,
	Mark Hahn <hahn@physics.mcmaster.ca>
References: <20030615160524.GD1063@wohnheim.fh-wedel.de> <20030615182642.A19479@infradead.org> <20030615173926.GH1063@wohnheim.fh-wedel.de> <20030615184417.A19712@infradead.org> <20030615175815.GI1063@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030615175815.GI1063@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Sun, Jun 15, 2003 at 07:58:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 07:58:15PM +0200, Jörn Engel wrote:
> Ok, you win this one.  Leaves this case:
> $ mount /dev/somewhere /mnt
> cramfs: wrong magic
> $ echo $?
> 0
> $

Umm, please explain.  You got a sucessfull mount of a non-cramfs
filesystem type but an error from cramfs?  What version of mount
do you use?

> Here I consider the message evil as well.  The patch below on the
> other hand might go a little too far.  All the other printk()s are
> rare and might hold some useful information for normal users as well.
> 
> Any arguments for or against this patch?

It's not a debug printk.  Please leave the messages in, it's really
helpful to see what failed when mount doesn't succeed.

