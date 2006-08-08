Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWHHPDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWHHPDH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWHHPDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:03:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4778 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964942AbWHHPDF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:03:05 -0400
Subject: Re: + sys_getppid-oopses-on-debug-kernel.patch added to -mm tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, dev@sw.ru, dev@openvz.org,
       stable@kernel.org
In-Reply-To: <20060808145709.GB3953@rhun.haifa.ibm.com>
References: <200608081432.k78EWprf007511@shell0.pdx.osdl.net>
	 <20060808143937.GA3953@rhun.haifa.ibm.com>
	 <20060808145138.GA2720@atjola.homenet>
	 <20060808145709.GB3953@rhun.haifa.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Tue, 08 Aug 2006 16:22:27 +0100
Message-Id: <1155050547.5729.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-08 am 17:57 +0300, ysgrifennodd Muli Ben-Yehuda:
> On Tue, Aug 08, 2006 at 04:51:38PM +0200, Björn Steinbrink wrote:
> 
> > There's a note right above the function that explains it:
> >  * NOTE! This depends on the fact that even if we _do_
> >  * get an old value of "parent", we can happily dereference
> >  * the pointer (it was and remains a dereferencable kernel pointer
> >  * no matter what): we just can't necessarily trust the result
> >  * until we know that the parent pointer is valid.
> 
> Even without getting into just how ugly this is, is it really worth
> it?

It never was in my opinion but I lost that battle to Linus in 1.3.40 or
so timescales. Given how critical getppid _isnt_ I don't see the point
in being clever.
