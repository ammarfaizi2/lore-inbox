Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263150AbTCWTSE>; Sun, 23 Mar 2003 14:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263152AbTCWTSE>; Sun, 23 Mar 2003 14:18:04 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29093
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263150AbTCWTSC>; Sun, 23 Mar 2003 14:18:02 -0500
Subject: Re: sleeping function call in 2.5.65-bk
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dan carpenter <d_carpenter@sbcglobal.net>
Cc: Brian Gerst <bgerst@didntduck.org>, Thomas Molina <tmolina@cox.net>,
       jsimmons@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303231905.h2NJ57OU665784@pimout3-ext.prodigy.net>
References: <Pine.LNX.4.44.0303230958450.891-100000@localhost.localdomain>
	 <3E7DE12C.2020301@quark.didntduck.org>
	 <200303231905.h2NJ57OU665784@pimout3-ext.prodigy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048452091.10727.71.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2003 20:41:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 01:44, dan carpenter wrote:
> On Sunday 23 March 2003 05:30 pm, Brian Gerst wrote:
> >
> > The fbcon driver is calling kmalloc in interrupt context without
> > GFP_ATOMIC.
> 
> Good call.  This is compile tested only.

It was wrong before its now even more wrong. Suppose the allocation
fails. Previously that was wildly improbable (but crashed) now its
likely (and crashes0

This code has bigger issues

