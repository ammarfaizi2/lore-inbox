Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265202AbUEVJmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265202AbUEVJmA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 05:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265205AbUEVJl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 05:41:59 -0400
Received: from canuck.infradead.org ([205.233.217.7]:46598 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S265202AbUEVJl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 05:41:58 -0400
Date: Sat, 22 May 2004 05:41:53 -0400
From: hch@infradead.org
To: Andrew Morton <akpm@osdl.org>
Cc: brking@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
Message-ID: <20040522094153.GA3672@infradead.org>
Mail-Followup-To: hch@infradead.org, Andrew Morton <akpm@osdl.org>,
	brking@us.ibm.com, linux-kernel@vger.kernel.org
References: <20040522013636.61efef73.akpm@osdl.org> <20040522092627.GA3432@infradead.org> <20040522023218.4d3e34e3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522023218.4d3e34e3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 02:32:18AM -0700, Andrew Morton wrote:
> > code more readable sometimes) or stick a
> 
> It uses a *ton* of anonymous unions.
> 
> > #if (__GNUC__ < 3)
> > # error "This driver requires GCC 3.x"
> > #endif
> 
> That breaks allfooconfig.

Well, the patch currently in -mm also breaks allmodconfig.  Just not on
your arch or with a recent enough compiler, while with this it'll break
an all arches unless you have a recent enough compiler.  And give the
driver isn't actually ppc specific that sounds like a really bad tradeoff.

