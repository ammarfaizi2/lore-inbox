Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVCNOzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVCNOzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 09:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVCNOzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 09:55:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44190 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261521AbVCNOzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 09:55:33 -0500
Subject: Re: bug in kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Evgeniy <shubin_evgeniy@mail.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1110811871.6288.85.camel@laptopd505.fenrus.org>
References: <200503141748.05661.shubin_evgeniy@mail.ru>
	 <1110811871.6288.85.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 15:55:29 +0100
Message-Id: <1110812130.6288.89.camel@laptopd505.fenrus.org>
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

On Mon, 2005-03-14 at 15:51 +0100, Arjan van de Ven wrote:
> On Mon, 2005-03-14 at 17:48 +0300, Evgeniy wrote:
> > Here is a simple program.
> > 
> > #include <stdio.h>
> > #include <errno.h>
> > main(){
> >   int err;
> >   err=read(0,NULL,6);
> >   printf("%d %d\n",err,errno);
> > }
> > 
> > I think that it should be an error : Null pointer assignment, like in windows.
> > But in practise it is not so. 
> > Mandrake Linux kernel 2.4.21-0.13mdk
> > I am a programmer too and i am very interested to solve this problem. Please, 
> > send me fragment of sourse code of kernel with this bug.
> 
> well what is the value of errno ?
> -EFAULT by chance ?

note that you need to include <unistd.h> for the proper read() prototype
btw

