Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVDMLNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVDMLNp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 07:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVDMLNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 07:13:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39889 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261311AbVDMLNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 07:13:43 -0400
Subject: Re: insmod segfault in pci_find_subsys()
From: Arjan van de Ven <arjan@infradead.org>
To: Toralf Lund <toralf@procaptura.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <425CFBDA.9040301@procaptura.com>
References: <423A9B65.1020103@procaptura.com>
	 <20050318170709.GD14952@kroah.com> <42496309.3080007@procaptura.com>
	 <20050413071233.GB25581@kroah.com>  <425CFBDA.9040301@procaptura.com>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 13:13:38 +0200
Message-Id: <1113390818.6275.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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


> Yes. You are right. I actually mentioned this on a different thread: I 
> eventually found out that the kernel was compiled with -mregparam=3, and 
> the module was not. This option seems to have been added to the default 
> config and/or Red Hat's build setup sometime before the current kernel 
> release, but after the start of the 2.6 series...

that means your makefile indeed is utterly bust. A correct makefile for
an external module correctly and automatically inherits all the CFLAGs
used by the kernel.

Care to point to a full URL of your module so that we can help you by
sending patches?


