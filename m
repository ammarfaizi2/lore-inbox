Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVA3SQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVA3SQS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 13:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVA3SQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 13:16:18 -0500
Received: from canuck.infradead.org ([205.233.218.70]:54029 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261759AbVA3SQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 13:16:12 -0500
Subject: Re: inter-module-* removal.. small next step
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Michael Werner <werner@mrcoffee.engr.sgi.com>,
       linux-kernel@vger.kernel.org, dwmw2@infradead.org,
       davej@codemonkey.org.uk, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050130181042.GR3185@stusta.de>
References: <20050130180016.GA12987@infradead.org>
	 <20050130181042.GR3185@stusta.de>
Content-Type: text/plain
Date: Sun, 30 Jan 2005 19:15:32 +0100
Message-Id: <1107108932.4306.57.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-30 at 19:10 +0100, Adrian Bunk wrote:
> On Sun, Jan 30, 2005 at 06:00:17PM +0000, Arjan van de Ven wrote:
> 
> > Hi,
> > 
> > intermodule is deprecated for quite some time now, and MTD is the sole last
> > user in the tree. To shrink the kernel for the people who don't use MTD, and
> > to prevent accidental return of more users of this, make the compiling of
> > this function conditional on MTD.
> >...
> 
> agpgart-allow-multiple-backends-to-be-initialized.patch in -mm adds a 
> call to inter_module_unregister to drivers/char/agp/backend.c ...

that is a bug in -mm; inter-module* got removed from agp entirely some
time ago 

sounds like andrew has some bad patchnoise in his his agp patch


