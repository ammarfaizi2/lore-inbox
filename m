Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932819AbWCQWhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932819AbWCQWhW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 17:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932821AbWCQWhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 17:37:22 -0500
Received: from smtp17.wanadoo.fr ([193.252.23.111]:3631 "EHLO
	smtp17.wanadoo.fr") by vger.kernel.org with ESMTP id S932819AbWCQWhV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 17:37:21 -0500
X-ME-UUID: 20060317223718540.0D2B0700008A@mwinf1706.wanadoo.fr
Date: Fri, 17 Mar 2006 23:43:11 +0100
From: Xavier Bestel <xavier.bestel@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org, aia21@cantab.net,
       len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-Id: <20060317234311.c5e338f6.xavier.bestel@free.fr>
In-Reply-To: <20060316132639.274691d6.akpm@osdl.org>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
	<20060316164932.GT27946@ftp.linux.org.uk>
	<20060316132639.274691d6.akpm@osdl.org>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006 13:26:39 -0800
Andrew Morton <akpm@osdl.org> wrote:

> C99 does have boolean support, so the proper thing to do is to start
> using it - implement stdbool.h, fix up fallout, start fixing subsystems. 
> Given that, and as Greg has fixed up this particular build error I'll drop
> the patch.

Isn't there a runtime cost converting all "non-false" values to a unique "true" (i.e. converting non-zero values to one) ?
I mean:

bool res = strcmp(string, "whatever");
if(res)
	something_else();

... will convert res to 0 or 1, which is totally useless except perhaps for comprehension (and again, not for Al Viro for example :)

	Xav

