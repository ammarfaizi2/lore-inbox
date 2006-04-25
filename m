Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWDYJWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWDYJWo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWDYJWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:22:43 -0400
Received: from smtp1.wanadoo.fr ([193.252.22.30]:13637 "EHLO smtp1.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932168AbWDYJWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:22:42 -0400
X-ME-UUID: 20060425092241730.B23791C00221@mwinf0101.wanadoo.fr
Subject: Re: C++ pushback
From: Xavier Bestel <xavier.bestel@free.fr>
To: Avi Kivity <avi@argo.co.il>
Cc: Martin Mares <mj@ucw.cz>, "J.A. Magallon" <jamagallon@able.es>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <444DE829.2000101@argo.co.il>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
	 <mj+md-20060424.201044.18351.atrey@ucw.cz>
	 <444D44F2.8090300@wolfmountaingroup.com>
	 <1145915533.1635.60.camel@localhost.localdomain>
	 <20060425001617.0a536488@werewolf.auna.net>
	 <1145952948.596.130.camel@capoeira> <444DE0F0.8060706@argo.co.il>
	 <mj+md-20060425.085030.25134.atrey@ucw.cz> <444DE539.4000804@argo.co.il>
	 <mj+md-20060425.090134.27024.atrey@ucw.cz>  <444DE829.2000101@argo.co.il>
Content-Type: text/plain
Message-Id: <1145956952.596.212.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Tue, 25 Apr 2006 11:22:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 11:13, Avi Kivity wrote:
> Martin Mares wrote:
> >>> Calling a C function is simple and explicit -- a quick glance over
> >>> the code is enough to tell what gets called.
> >>>
> >>>       
> >> No, you need to check all the functions it calls as well.
> >>     
> >
> > Yes, but if it calls none (or calls basic functions I already know),
> > it's immediately visible without having to circumnavigate the globe
> > to find declarations of all sub-objects :)
> >
> >   
> Yes, but if the constructor constructs no sub objects (or basic objects 
> you already know) then it's immediately visible as well.

Yes, "if". With straight C, it's immediatly obvious the kmalloc() is the
only function with side-effects and special requirements - an
experienced hacker won't even look it up. With C++ those may be hidden
behind each object or object member, that's the philosophy of the
language. 
The problem is that in kernel mode you must know precisely when and how
you allocate memory.

	Xav


