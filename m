Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268759AbUIXOE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268759AbUIXOE7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268766AbUIXOE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:04:59 -0400
Received: from holomorphy.com ([207.189.100.168]:11744 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268759AbUIXOE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:04:58 -0400
Date: Fri, 24 Sep 2004 07:04:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Q] possible proc inode numbers overflow?
Message-ID: <20040924140408.GF9106@holomorphy.com>
References: <41542ADF.5070202@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41542ADF.5070202@sw.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 06:10:39PM +0400, Kirill Korotaev wrote:
> fs/proc/generic.c:
> #define PROC_DYNAMIC_FIRST 0xF0000000UL
> static unsigned int get_inode_number(void)
> {
> 	...
>         inum = (i & MAX_ID_MASK) + PROC_DYNAMIC_FIRST;
> 
>         /* inum will never be more than 0xf0ffffff, so no check
>          * for overflow.
>          */
> 	...
> }
> is it really correct? Looks like MAX_ID_MASK = 0x7FFFFFFF and 
> PROC_DYNAMIC_FIRST is 0xF0000000.
> So at least the comment is wrong?

The comment is wrong. Albert Cahalan and I are working on a new fix.


-- wli
