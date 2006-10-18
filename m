Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWJRAzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWJRAzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 20:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWJRAzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 20:55:31 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:6083 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751211AbWJRAza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 20:55:30 -0400
Subject: Re: [PATCH 0/5] Allow more than PAGESIZE data read in configfs
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20061016230913.GN2747@ca-server1.us.oracle.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <20061011131935.448a8696.akpm@osdl.org>
	 <20061011221822.GD7911@ca-server1.us.oracle.com>
	 <20061011154836.9befa359.akpm@osdl.org>
	 <1160609233.6389.82.camel@linuxchandra> <20061014080107.GB19325@kroah.com>
	 <20061014124351.63434962.akpm@osdl.org>
	 <20061014201016.GG2747@ca-server1.us.oracle.com>
	 <1161026675.6389.128.camel@linuxchandra>
	 <20061016230913.GN2747@ca-server1.us.oracle.com>
Content-Type: text/plain
Organization: IBM
Date: Tue, 17 Oct 2006 17:55:28 -0700
Message-Id: <1161132928.5057.18.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 16:09 -0700, Joel Becker wrote:
> On Mon, Oct 16, 2006 at 12:24:35PM -0700, Chandra Seetharaman wrote:
> > On Sat, 2006-10-14 at 13:10 -0700, Joel Becker wrote:
> > > 	Issues of PAGE_SIZE and attribute size aside, the patch posted
> > > was incorrect.  While they used seq_file, they implemented it in a
> > 
> > I do not think it is incorrect. It provides a simplest interface to
> > configfs's clients.
> 
> 	I understand that it provides a simple sed(1)-based change for
> existing clients.  However, it abuses seq_file in exactly the wrong way.
> 
> > > completely inefficent fashion, filling the entire buffer in one ->show()
> > > call rather than letting multiple read(2) calls iterate their list.
> > 
> > So, are you suggesting that we should provide a generic seq_operations
> > interface to configfs's clients ?
> 
> 	Yes, if we provide a vector type in any way, it should be via
> seq_operations or something like it.  If we're going to use seq_file, we
> should use it correctly.
> 

So, you want me to make a patch that uses seq_op instead of seq_file ? 
I am willing to do it.

> Joel
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


