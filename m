Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTJPO4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 10:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbTJPO4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 10:56:38 -0400
Received: from holomorphy.com ([66.224.33.161]:2948 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263002AbTJPO4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 10:56:36 -0400
Date: Thu, 16 Oct 2003 07:58:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.6.0-test7-mm1
Message-ID: <20031016145859.GD723@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Steven Pratt <slpratt@austin.ibm.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>
References: <3F8EAEB5.5040102@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8EAEB5.5040102@austin.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 09:44:05AM -0500, Steven Pratt wrote:
> On reboot after heavy IO loads (tiobench) I keep getting the following 
> oops. Happens right after the "turning off swap" message. Root FS is 
> ext3, but the oops has happened while testing ext2 and ext3 with 
> tiobench(xfs, jfs and rieser still to come).
> kernel BUG at include/linux/list.h:148!
> invalid operand: 0000 [#1]
> SMP
> CPU:    2
> EIP:    0060:[<c01756f7>]    Not tainted VLI
> EFLAGS: 00010213
> EIP is at __iget+0x67/0x80

Could you try with the invalidate_inodes-speedup.patch backed out?


-- wli
