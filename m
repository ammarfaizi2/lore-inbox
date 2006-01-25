Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWAYIHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWAYIHa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 03:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWAYIHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 03:07:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7049 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750768AbWAYIH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 03:07:29 -0500
Subject: Re: [PATCH 1/5] stack overflow safe kdump (2.6.16-rc1-i386) -
	safe_smp_processor_id
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, fernando@intellilink.co.jp, ebiederm@xmission.com,
       vgoyal@in.ibm.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
In-Reply-To: <20060124235901.719aa375.akpm@osdl.org>
References: <1138171868.2370.62.camel@localhost.localdomain>
	 <20060124231052.7c9fcbec.akpm@osdl.org> <200601250853.48193.ak@suse.de>
	 <20060124235901.719aa375.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 09:07:18 +0100
Message-Id: <1138176439.3001.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 23:59 -0800, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > On Wednesday 25 January 2006 08:10, Andrew Morton wrote:
> > 
> > > It assumes that all x86 SMP machines have APICs.  That's untrue of Voyager.
> > > I think we can probably live with this assumption - others would know
> > > better than I.
> > 
> > Early x86s didn't have APICs and they are still often disabled on not so 
> > old mobile CPUs.  I don't think it's a good assumption to make for i386.
> > 
> 
> But how many of those do SMP?

even on SMP boxes you regularly need to (runtime) disable apics. Several
boards out there just have busted apics, or at least when used with
linux. "noapic" is one of the more frequent things distro support people
tell customers over the phone....


