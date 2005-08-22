Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVHVUlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVHVUlg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVHVUlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:41:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12762 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751098AbVHVUlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:41:35 -0400
Date: Mon, 22 Aug 2005 16:33:54 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, mlindner@syskonnect.de
Subject: Re: skge missing ifdefs.
Message-ID: <20050822203354.GB3425@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, mlindner@syskonnect.de
References: <20050801203442.GD2473@redhat.com> <20050801203818.GA7497@havoc.gtf.org> <20050822195913.GF27344@redhat.com> <20050822132333.2ff893e6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822132333.2ff893e6.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 01:23:33PM -0700, Andrew Morton wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > >
 > > On Mon, Aug 01, 2005 at 04:38:18PM -0400, Jeff Garzik wrote:
 > >  > On Mon, Aug 01, 2005 at 04:34:42PM -0400, Dave Jones wrote:
 > >  > > with CONFIG_PM undefined, the build breaks due to 
 > >  > > undefined symbols.
 > >  > 
 > >  > akpm already sent a fix to Linus.
 > > 
 > > This is still broken afaics in todays -git.
 > > 
 > 
 > Works for me.  CONFIG_PM=n, CONFIG_SKGE=y or m, CONFIG_SK98LIN=y or m.

I missed the ..

#define skge_suspend NULL
#define skge_resume NULL

in drivers/net/sk98lin/skge.c, and wondered why my drivers/net/skge.c style fix
still applied.

Never mind, both drivers seem fine.

		Dave

