Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbUBZUry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbUBZUrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:47:53 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:13818 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S261318AbUBZUrU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:47:20 -0500
Date: Thu, 26 Feb 2004 13:47:14 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Fix dev_printk to work with unclaimed devices
Message-ID: <20040226204714.GB17722@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040226183439.GA17722@plexity.net> <20040226185324.GA11980@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226185324.GA11980@kroah.com>
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26 2004, at 10:53, Greg KH was caught saying:
> On Thu, Feb 26, 2004 at 11:34:39AM -0700, Deepak Saxena wrote:
> > 
> > I need to do some fixup in platform_notify() and when trying to 
> > use the dev_* print functions for informational messages, they OOPs 
> > b/c the current code assumes that dev->driver exists. This is not the 
> > case since platform_notify() is called before a device has been attached
> > to any driver. 
> 
> Yeah, this "limitation" of the dev_* printks have been known for a
> while, and it was determined that for situations like this, it's not
> worth using those calls.

I can just use printks as it is only two quick log messages at
init time.

Tnx,
~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/
