Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVE3QCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVE3QCE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 12:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVE3QCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 12:02:03 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:52253 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261633AbVE3QB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 12:01:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from;
        b=BpeVZS6jGTtU8hUTkNDOxo4qHbbv8rb7zWn0S8ddiT0VizKHxOcuMSg9oLyZULkL3e+NLchHtFLzgtG0MM1U45pTX9gyXH2dbHPImMuf7XLUVWyJxCNUACWU0tVUBuUY1SYsYUerVFPGfw/WRrfD7FQtC9EESFLJMhxmw6BdDnw=
Date: Mon, 30 May 2005 18:01:48 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050530160147.GD14351@gmail.com>
References: <20050521232220.GD28654@gmail.com> <1116770040.5002.13.camel@mulgrave> <20050524153930.GA10911@gmail.com> <1117113563.4967.17.camel@mulgrave> <20050526143516.GA9593@gmail.com> <1117118766.4967.22.camel@mulgrave> <20050526173518.GA9132@gmail.com> <1117463938.4913.3.camel@mulgrave> <20050530150950.GA14351@gmail.com> <1117467248.4913.9.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1117467248.4913.9.camel@mulgrave>
User-Agent: Mutt/1.5.6i
From: =?iso-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 10:34:08AM -0500, James Bottomley wrote:

> Yes, that was just a global change to get the thing to boot.

And it works :-)

> Now try this:
> 
> echo 100 > /sys/class/spi_transport/target1:0:1/min_period
> echo 1 > /sys/class/spi_transport/target1:0:1/revalidate
> 
> and look at dmesg to see if it brought the speed up (save your files
> first, this may hang the box).

It don't hang my box... and I got this :

 target1:0:1: Beginning Domain Validation
 target1:0:1: Domain Validation skipping write tests
(scsi1:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
 target1:0:1: Ending Domain Validation

Thank,
-- 
	Grégoire Favre
