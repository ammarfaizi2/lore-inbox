Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264430AbUEDPFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUEDPFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 11:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbUEDPFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 11:05:34 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:25236 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264428AbUEDPFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 11:05:25 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, peter@mysql.com, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20040503232928.1b13037c.akpm@osdl.org>
References: <200405022357.59415.alexeyk@mysql.com>
	 <409629A5.8070201@yahoo.com.au> <20040503110854.5abcdc7e.akpm@osdl.org>
	 <1083615727.7949.40.camel@localhost.localdomain>
	 <20040503135719.423ded06.akpm@osdl.org>
	 <1083620245.23042.107.camel@abyss.local>
	 <20040503145922.5a7dee73.akpm@osdl.org> <4096DC89.5020300@yahoo.com.au>
	 <20040503171005.1e63a745.akpm@osdl.org> <4096E1A6.2010506@yahoo.com.au>
	 <1083631804.4544.16.camel@localhost.localdomain>
	 <20040503232928.1b13037c.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1083683034.13688.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 May 2004 08:03:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 23:29, Andrew Morton wrote:
 
> 
> Putting a semaphore around do_generic_file_read() or maintaining the state
> as below fixes it up.
> 
> I wonder if we should bother fixing this?  I guess as long as the app is
> using pread() it is a legitimate thing to be doing, so I guess we should...
> 
> 
> 
Yes this patch makes sense. I have setup sysbench on my lab machine. Let
me see how much improvement the patch provides.


RP
 

