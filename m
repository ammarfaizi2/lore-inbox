Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbTAMORl>; Mon, 13 Jan 2003 09:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbTAMORl>; Mon, 13 Jan 2003 09:17:41 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12952
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267221AbTAMORl>; Mon, 13 Jan 2003 09:17:41 -0500
Subject: Re: patch for errno-issue (with soundcore)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200301131457.24264.thomas.schlichter@web.de>
References: <200301131457.24264.thomas.schlichter@web.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042470839.18624.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 13 Jan 2003 15:13:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 13:57, Thomas Schlichter wrote:
> Hi,
> 
> here is a simple patch to export the errno-symbol from the /lib/errno.c file. 
> This solves the problem with the soundcore module and works perfectly for 
> me...

This actually shows a bug that has always been lurking. What if we load two
modules firmware at the same time. errno needs to be task private or we
perhaps need an errno_sem ?

