Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264607AbUEDTsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264607AbUEDTsh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 15:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUEDTsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 15:48:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:57039 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264607AbUEDTsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 15:48:36 -0400
Date: Tue, 4 May 2004 12:48:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: nickpiggin@yahoo.com.au, peter@mysql.com, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
Message-Id: <20040504124800.67e1c819.akpm@osdl.org>
In-Reply-To: <1083699554.13688.64.camel@localhost.localdomain>
References: <200405022357.59415.alexeyk@mysql.com>
	<409629A5.8070201@yahoo.com.au>
	<20040503110854.5abcdc7e.akpm@osdl.org>
	<1083615727.7949.40.camel@localhost.localdomain>
	<20040503135719.423ded06.akpm@osdl.org>
	<1083620245.23042.107.camel@abyss.local>
	<20040503145922.5a7dee73.akpm@osdl.org>
	<4096DC89.5020300@yahoo.com.au>
	<20040503171005.1e63a745.akpm@osdl.org>
	<4096E1A6.2010506@yahoo.com.au>
	<1083631804.4544.16.camel@localhost.localdomain>
	<20040503232928.1b13037c.akpm@osdl.org>
	<1083683034.13688.7.camel@localhost.localdomain>
	<1083699554.13688.64.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai <linuxram@us.ibm.com> wrote:
>
> I ran the following command:
> 
>  /root/sysbench-0.2.5/sysbench/sysbench --num-threads=256 --test=fileio
>  --file-total-size=2800M --file-test-mode=rndrw run 
> 

Alexey and I have been using 16 threads.

You don't tell us how much memory your lab machine has.  The above command
only makes sense if it is less than 400 megabytes.  Otherwise many or all
of the reads are satisfied from pagecache.

I've been testing with mem=256M, --file-total-size=2G.
