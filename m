Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVCOQaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVCOQaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVCOQ3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:29:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13240 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261408AbVCOQ0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:26:52 -0500
Subject: Re: [Ext2-devel] Re: [PATCH] 2.6.11-mm3 patch for ext3 writeback
	"nobh" option
From: Arjan van de Ven <arjan@infradead.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <1110902996.24286.328.camel@dyn318077bld.beaverton.ibm.com>
References: <1110827903.24286.275.camel@dyn318077bld.beaverton.ibm.com>
	 <20050314180917.07f7ac58.akpm@osdl.org>
	 <1110902996.24286.328.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 17:26:36 +0100
Message-Id: <1110903996.6290.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 08:09 -0800, Badari Pulavarty wrote:
> On Mon, 2005-03-14 at 18:09, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> > > Here is the 2.6.11-mm3 version of patch for adding "nobh"
> > >  support for ext3 writeback mode.
> > 
> > Care to update Documentation/filesystems/ext3.txt?
> 
> Yes. I will do that. I am planning to add "nobh" support to
> ext3 ordered mode also, since its the default one. We need
> to modify generic interfaces like mpage_writepage(s) to
> keep track of bio count and make journal code wait for them etc. -
> at that point the "generic" code will no longer be generic.
> I am thinking of a way to do it *less* intrusively. 
> 
> At that point, we can make "nobh" default option. (which
> needs less documentation).

I still don't get why you want a mount option. Sure during development
it can be nice.. but do you still want it in the production trees??
(I understand that for small blocksizes you need to fallback code, fine,
no problem, but why do you want to make it an *option* instead of
automatic)

