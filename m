Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422838AbWJPTYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422838AbWJPTYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422851AbWJPTYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:24:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:65160 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422838AbWJPTYj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:24:39 -0400
Subject: Re: [PATCH 0/5] Allow more than PAGESIZE data read in configfs
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20061014201016.GG2747@ca-server1.us.oracle.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <20061011131935.448a8696.akpm@osdl.org>
	 <20061011221822.GD7911@ca-server1.us.oracle.com>
	 <20061011154836.9befa359.akpm@osdl.org>
	 <1160609233.6389.82.camel@linuxchandra> <20061014080107.GB19325@kroah.com>
	 <20061014124351.63434962.akpm@osdl.org>
	 <20061014201016.GG2747@ca-server1.us.oracle.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 16 Oct 2006 12:24:35 -0700
Message-Id: <1161026675.6389.128.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-14 at 13:10 -0700, Joel Becker wrote:
> On Sat, Oct 14, 2006 at 12:43:51PM -0700, Andrew Morton wrote:
> > On Sat, 14 Oct 2006 01:01:07 -0700
> > Greg KH <greg@kroah.com> wrote:
> > > Argh!!!!
> > > 
> > > Are you going to honestly tell me you have a single attribute in sysfs
> > > that is larger than PAGE_SIZE?
> > 
> > He does not.  It's a matter of reusing existing facilities rather than
> > impementing similar things in multiple places.  The equivalent patch in
> > configfs removed a decent amount of code:
> 
> 	Issues of PAGE_SIZE and attribute size aside, the patch posted
> was incorrect.  While they used seq_file, they implemented it in a

I do not think it is incorrect. It provides a simplest interface to
configfs's clients.

> completely inefficent fashion, filling the entire buffer in one ->show()
> call rather than letting multiple read(2) calls iterate their list.

So, are you suggesting that we should provide a generic seq_operations
interface to configfs's clients ?
 
> 
> Joel
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


