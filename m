Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265239AbTFMREP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbTFMREO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:04:14 -0400
Received: from air-2.osdl.org ([65.172.181.6]:27284 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265239AbTFMREO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:04:14 -0400
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
From: Andy Pfiffer <andyp@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: christophe@saout.de, adam@yggdrasil.com, linux-kernel@vger.kernel.org,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Unai Garro Arrazola <Unai.Garro@ee.ed.ac.uk>,
       Max Valdez <maxvalde@fis.unam.mx>,
       Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
In-Reply-To: <20030613010149.359cb4dd.akpm@digeo.com>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	 <1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	 <1052513725.15923.45.camel@andyp.pdx.osdl.net>
	 <1055369326.1158.252.camel@andyp.pdx.osdl.net>
	 <1055373692.16483.8.camel@chtephan.cs.pocnet.net>
	 <1055377253.1222.8.camel@andyp.pdx.osdl.net>
	 <20030611172958.5e4d3500.akpm@digeo.com>
	 <1055438856.1202.6.camel@andyp.pdx.osdl.net>
	 <20030612105347.6ea644b7.akpm@digeo.com>
	 <1055441028.1202.11.camel@andyp.pdx.osdl.net>
	 <1055442331.1225.11.camel@andyp.pdx.osdl.net>
	 <20030613010149.359cb4dd.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055524632.1233.1.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Jun 2003 10:17:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-13 at 01:01, Andrew Morton wrote:
> Fix this by just leaving the inode dirty and moving on to inspect the other
> blockdev inodes on sb->s_io.

Yup, this fixed it for me, too.  Thanks for your help.  --Andy



