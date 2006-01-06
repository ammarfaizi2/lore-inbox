Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWAFCHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWAFCHo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWAFCHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:07:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12268 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752185AbWAFCHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:07:21 -0500
Date: Thu, 5 Jan 2006 19:38:10 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexander Gran <alex@zodiac.dnsalias.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, len.brown@intel.com, ambx1@neo.rr.com,
       reiserfs-dev@namesys.com, airlied@linux.ie, vs@namesys.com,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: Re: Re. 2.6.15-mm1
Message-ID: <20060106003810.GA22051@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Alexander Gran <alex@zodiac.dnsalias.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	len.brown@intel.com, ambx1@neo.rr.com, reiserfs-dev@namesys.com,
	airlied@linux.ie, vs@namesys.com,
	"Seth, Rohit" <rohit.seth@intel.com>
References: <200601051801.29007@zodiac.zodiac.dnsalias.org> <20060105144720.25085afa.akpm@osdl.org> <200601060033.34276@zodiac.zodiac.dnsalias.org> <20060105162151.6fc1716f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105162151.6fc1716f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 04:21:51PM -0800, Andrew Morton wrote:

 > > Am Donnerstag, 5. Januar 2006 23:47 schrieb Andrew Morton:
 > > > > Jan  5 16:22:47 t40 kernel: mtrr: 0xe0000000,0x8000000 overlaps existing
 > > > > 0xe0000000,0x4000000
 > > > > Jan  5 16:22:48 t40 last message repeated 2 times
 > > >
 > > > Is that new?
 > > 
 > > Umm, no. I just thought it could be related to the X oops.
 > 
 > OK.  I don't know how common this is, nor whether it'll cause problems. 
 > David(s), do you know?

at worse, a video performance hit.

 > > EIP is at agp_collect_device_status+0x14/0xd4
 > OK.  I've been assuming that this is a DRM bug but I note that the AGP tree
 > has been dinking with agp_collect_device_status(), so perhaps I had the wrong
 > David.

I'm a moron. I'll fix it up.
I only tested the 'have no agp' case which this changed, and didn't test
the commoncase 'have agp'.  Doh.

		Dave

