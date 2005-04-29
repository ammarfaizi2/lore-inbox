Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVD2VAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVD2VAA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbVD2U70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:59:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:21917 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262977AbVD2U5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:57:44 -0400
Date: Fri, 29 Apr 2005 13:57:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: suparna@in.ibm.com, sct@redhat.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC] Adding multiple block allocation
Message-Id: <20050429135705.3f4831bd.akpm@osdl.org>
In-Reply-To: <1114803764.10473.46.camel@localhost.localdomain>
References: <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	<1113244710.4413.38.camel@localhost.localdomain>
	<1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	<1113288087.4319.49.camel@localhost.localdomain>
	<1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	<1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	<1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	<1114207837.7339.50.camel@localhost.localdomain>
	<1114659912.16933.5.camel@mindpipe>
	<1114715665.18996.29.camel@localhost.localdomain>
	<20050429135211.GA4539@in.ibm.com>
	<1114794608.10473.18.camel@localhost.localdomain>
	<1114803764.10473.46.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> If we do direct write(block allocation) to a hole, I found that the
>  "create" flag passed to ext3_direct_io_get_blocks() is 0 if we are
>  trying to _write_ to a file hole. Is this expected? 

Nope.  The code in get_more_blocks() is pretty explicit.

> But if it try to allocating blocks in the hole (with direct IO), blocks
> are allocated one by one. I am looking at it right now.
> 

Please see the comment over get_more_blocks().
