Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbVLISpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVLISpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVLISpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:45:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51881 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932513AbVLISpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:45:41 -0500
Date: Fri, 9 Dec 2005 13:45:17 -0500
From: Dave Jones <davej@redhat.com>
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: tripperda@nvidia.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       ak@suse.de, jgarzik@pobox.com
Subject: Re: PAT status?
Message-ID: <20051209184517.GB7473@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Daniel J Blueman <daniel.blueman@gmail.com>, tripperda@nvidia.com,
	Linux Kernel <linux-kernel@vger.kernel.org>, ak@suse.de,
	jgarzik@pobox.com
References: <6278d2220512080737t30a83011k11e88e85c0974a11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6278d2220512080737t30a83011k11e88e85c0974a11@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 03:37:43PM +0000, Daniel J Blueman wrote:
 > Terence Ripperda wrote:
 > > Hi Jeff,
 > >
 > > I unfortunately haven't had much time to look at the status of the PAT
 > > code I had been working on. there are really 2 steps to the code:
 > >
 > > the first is enabling and configuring the PAT registers. this then
 > > allows a page table entry define that can be passed to traditional
 > > interfaces, such as remap_page_range or change_page_attr. this is
 > > pretty simple and we've been using a similar interface in our driver
 > > for some time now.
 > 
 > Presumably, the aliasing will only bite where eg the X server sets up
 > MTRRs and PAT is used for the region also. For x86_64 and IA32, the
 > Intel IA32 system guides tell us that strong store ordering (ie
 > write-through) takes precendence over weaker store ordering (eg
 > write-combining), so we should be safe. For processors with known
 > errata with PAT etc, we can disable PAT support.
 > 
 > Would it be useful to get a rough patch covering point #1 onto LKML
 > for discussion?

http://lwn.net/Articles/135883/ is Terrence's last patch
rediffed against 2.6.12 patch.

		Dave

