Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264874AbUFGQTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbUFGQTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 12:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbUFGQTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 12:19:41 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:50390 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264874AbUFGQTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 12:19:38 -0400
Date: Mon, 7 Jun 2004 18:19:31 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Daniel Egger <de@axiros.com>, cijoml@volny.cz,
       linux-kernel@vger.kernel.org
Subject: Re: jff2 filesystem in vanilla
Message-ID: <20040607161931.GB3521@wohnheim.fh-wedel.de>
References: <200406041000.41147.cijoml@volny.cz> <F84CE3DA-B605-11D8-B781-000A958E35DC@axiros.com> <1086390590.4588.70.camel@imladris.demon.co.uk> <3F4B6D09-B6CA-11D8-B781-000A958E35DC@axiros.com> <1086425211.4588.88.camel@imladris.demon.co.uk> <97F190B4-B6F5-11D8-B781-000A958E35DC@axiros.com> <1086454880.4588.594.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1086454880.4588.594.camel@imladris.demon.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 June 2004 18:01:21 +0100, David Woodhouse wrote:
> On Sat, 2004-06-05 at 15:38 +0200, Daniel Egger wrote:
> > On 05.06.2004, at 10:46, David Woodhouse wrote:
> > > If you're going to use JFFS2 on CF, you should really investigate using
> > > the write-buffer we implemented for NAND flash, but without the ECC
> > > parts.
> 
> > However, do you have any specific pointers where to look?
> 
> fs/jffs2/wbuf.c has most of the magic for buffering writes on NAND
> flash. We want to use that, but we want to avoid the ECC handling which
> we also do on NAND flash.

It's relatively simple to adjust. Took me two weeks to tweak it for
some "interesting" piece of NOR-Flash:
http://mhonarc.axis.se/jffs-dev/msg01402.html

The above Works For Me (tm), but is really ugly.  Someone should clean
it up and merge it into cvs someday.  Maybe it's useful for you.

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
