Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWHIRkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWHIRkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWHIRkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:40:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19334 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751236AbWHIRkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:40:21 -0400
Date: Wed, 9 Aug 2006 13:38:30 -0400
From: Dave Jones <davej@redhat.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Muli Ben-Yehuda <muli@il.ibm.com>,
       =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, dev@openvz.org, stable@kernel.org
Subject: Re: + sys_getppid-oopses-on-debug-kernel.patch added to -mm tree
Message-ID: <20060809173830.GA10930@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Kirill Korotaev <dev@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Muli Ben-Yehuda <muli@il.ibm.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	linux-kernel@vger.kernel.org, dev@openvz.org, stable@kernel.org
References: <200608081432.k78EWprf007511@shell0.pdx.osdl.net> <20060808143937.GA3953@rhun.haifa.ibm.com> <20060808145138.GA2720@atjola.homenet> <20060808145709.GB3953@rhun.haifa.ibm.com> <1155050547.5729.91.camel@localhost.localdomain> <44D8B048.8060103@sw.ru> <20060808163635.GF28990@redhat.com> <44D99901.20202@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D99901.20202@sw.ru>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 12:12:49PM +0400, Kirill Korotaev wrote:
 > >  > >>Even without getting into just how ugly this is, is it really worth
 > >  > >>it?
 > >  > it is impossible to run debug kernels w/o this patch :/
 > >  > or are you asking whether this optimization worth it?
 > >  > 
 > >  > What makes me worry is that this is a sign that vendors
 > >  > don't even bother to run debug kernels :((((
 > > 
 > > Fedora rawhide is nearly always shipping with DEBUG_SLAB enabled,
 > > and we didn't hit this once.  Are you sure this is a problem
 > > with DEBUG_SLAB, and not DEBUG_PAGEALLOC ?
 > Sorry, it's my fault. Surely, CONFIG_DEBUG_PAGEALLOC.

Then you're correct, vendors rarely turn this on :)
I do sometimes if I'm trying to chase down something particularly
difficult, and it usually gets me a bunch of mail from users
asking why 'everything got all slow', so it's a last-resort option
rather than a 'on all the time' option.

		Dave

-- 
http://www.codemonkey.org.uk
