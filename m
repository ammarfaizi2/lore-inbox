Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUAYA6l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 19:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbUAYA6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 19:58:41 -0500
Received: from dsl081-085-091.lax1.dsl.speakeasy.net ([64.81.85.91]:63105 "EHLO
	mrhankey.megahappy.net") by vger.kernel.org with ESMTP
	id S262888AbUAYA6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 19:58:40 -0500
Date: Sat, 24 Jan 2004 16:57:45 -0800 (PST)
From: Bryan Whitehead <driver@megahappy.net>
X-X-Sender: driver@mrhankey.homeip.net
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, nathans@sgi.com,
       owner-xfs@oss.sgi.com
Subject: Re: [PATCH 2.6.2-rc1-mm2] fs/xfs/xfs_log_recover.c
In-Reply-To: <20040124082606.A3107@infradead.org>
Message-ID: <Pine.LNX.4.58.0401241655010.32008@mrhankey.homeip.net>
References: <20040124073111.34B2313A354@mrhankey.megahappy.net>
 <20040124082606.A3107@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, one more thing. After removed the superflurous switch statement flags 
will have a value which fixes the warning.

If you look at the flow of code it is impossible for flags to not have a 
value when it gets to the if statement as the previous switch statement 
would give it a value. But since that switch statement only catches that 
one case anyway, it's better to merge the 2 switch statemnets.

On Sat, 24 Jan 2004, Christoph Hellwig wrote:

> On Fri, Jan 23, 2004 at 11:31:11PM -0800, Bryan Whitehead wrote:
> > 
> > This fixes a warning on compile of the xfs fs module.
> 
> This patch looks very strange.  What error do you get without it?
> 

-- 
Bryan Whitehead
Email:driver@megahappy.net
WorkE:driver@jpl.nasa.gov
