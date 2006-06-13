Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWFMRo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWFMRo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 13:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWFMRo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 13:44:58 -0400
Received: from thunk.org ([69.25.196.29]:10988 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750904AbWFMRo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 13:44:58 -0400
Date: Tue, 13 Jun 2006 13:44:07 -0400
From: Theodore Tso <tytso@mit.edu>
To: Avi Kivity <avi@argo.co.il>
Cc: Nathan Scott <nathans@sgi.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Message-ID: <20060613174407.GA6561@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Avi Kivity <avi@argo.co.il>,
	Nathan Scott <nathans@sgi.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <20060613143230.A867599@wobbly.melbourne.sgi.com> <448EC51B.6040404@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448EC51B.6040404@argo.co.il>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2006 at 05:00:59PM +0300, Avi Kivity wrote:
> 
> It can be made into an inode operation:
> 
>    if (inode->i_ops->getblksize)
>         return inode->i_ops->getblksize(inode);
>    else
>         return inode->i_sb->s_blksize;
> 
> Trading some efficiency for space.

Yep, that was what I was planning on doing....

						- Ted
