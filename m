Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbUKLRaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbUKLRaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 12:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbUKLR2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 12:28:10 -0500
Received: from postino4.roma1.infn.it ([141.108.26.24]:10668 "EHLO
	postino4.roma1.infn.it") by vger.kernel.org with ESMTP
	id S262586AbUKLRLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 12:11:09 -0500
Subject: Re: isa memory address
From: Antonino Sergi <Antonino.Sergi@roma1.infn.it>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58L.0411110329260.10663@blysk.ds.pg.gda.pl>
References: <1099901664.2718.92.camel@delphi.roma1.infn.it>
	 <418FA2F1.2090003@osdl.org>
	 <1100014956.30102.54.camel@delphi.roma1.infn.it>
	 <Pine.LNX.4.58L.0411091638570.9795@blysk.ds.pg.gda.pl>
	 <1100079437.30102.66.camel@delphi.roma1.infn.it>
	 <Pine.LNX.4.58L.0411110329260.10663@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Message-Id: <1100279455.16321.47.camel@delphi.roma1.infn.it>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 12 Nov 2004 18:10:55 +0100
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.28.0.12; VDF 6.28.0.70
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I tried but (on 2.4.2):
> > - request_region fails but, ignoring it and remapping physical address
> > to virtual, everything works fine, except for release_region, of course.
> > - request_mem_region works but what I get from communication with the
> > actual device are numbers that sometimes are surely wrong.
> 
>  As both request_region() and request_mem_region() merely reserve
> different resources in Linux structures, you can't get a different
> behavior from your device depending on which one you call, if any at all,
> unless you change code elsewhere at the same time.
> 

You were right, there was a wrong symlink that made me compile for 2.4
with headers from 2.2; maybe some different macro substitution lead to
an actual different code. Now it works fine, with 2.6 too.

Thank you

Antonino Sergi

>   Maciej


Antonino Sergi <Antonino.Sergi@Roma1.INFN.it>

Radiodating Laboratory
Physics Department
University of Rome "La Sapienza"
P.le Aldo Moro 2
00185 Rome Italy
Tel +390649914206
Fax +390649914208


