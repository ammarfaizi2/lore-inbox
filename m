Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbUC3SML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUC3SMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:12:10 -0500
Received: from [213.234.227.14] ([213.234.227.14]:14570 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S263790AbUC3SMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:12:07 -0500
Subject: Re: [Ext2-devel] Re: [RFC, PATCH] Reservation based ext3
	preallocation
From: Alex Tomas <alex@clusterfs.com>
Reply-To: alex@clusterfs.com
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       tytso@mit.edu, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <200403300907.33995.pbadari@us.ibm.com>
References: <200403190846.56955.pbadari@us.ibm.com>
	 <1080636930.3548.4549.camel@localhost.localdomain>
	 <20040330014523.6a368a69.akpm@osdl.org>
	 <200403300907.33995.pbadari@us.ibm.com>
Content-Type: text/plain; charset=KOI8-R
Organization: CFS Inc.
Message-Id: <1080666763.2119.20.camel@bzzz.home.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 30 Mar 2004 21:12:43 +0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ÷ÔÒ, 2004-03-30 at 21:07, Badari Pulavarty wrote:

> Can you explain this a little more ?  What does b->data and b->commited_data 
> represent ?  We are assuming that b->data will always be uptodate. 
> 

b_data represents actual information about used/free blocks.
b_committed_data represents blocks that freed during current
transaction. these blocks must not be allocated. there is good
note about this just before ext3_test_allocatable() in balloc.c


