Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVCHHMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVCHHMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 02:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVCHGud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:50:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:50575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261547AbVCHGrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:47:02 -0500
Date: Mon, 7 Mar 2005 22:46:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: sct@redhat.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC] ext3/jbd race: releasing in-use
 journal_heads
Message-Id: <20050307224618.1cae3425.akpm@osdl.org>
In-Reply-To: <20050308062827.GA3756@in.ibm.com>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050304160451.4c33919c.akpm@osdl.org>
	<1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050307123118.3a946bc8.akpm@osdl.org>
	<1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050307131113.0fd7477e.akpm@osdl.org>
	<1110230527.15117.625.camel@sisko.sctweedie.blueyonder.co.uk>
	<1110237205.15117.702.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050307155001.099352b5.akpm@osdl.org>
	<20050308062827.GA3756@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> 
> yup, looks like the same issue we hit in wait_on_page_writeback_range 
> during AIO work  - probably want to break out of the outer loop as well
> when this happens.

The `next = page_index' before breaking will do that for us.

> 
> How hard would it be to add an end_index parameter to the radix tree
> lookup, since we seem to be hitting this in multiple places ?

Really easy if you do it ;)

Let's wait for this particular peiece of code to settle down, do a cleanup
sometime?

