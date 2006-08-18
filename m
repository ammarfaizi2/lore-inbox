Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWHRKUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWHRKUk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 06:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWHRKUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 06:20:40 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:8388 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751344AbWHRKUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 06:20:40 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: 2.6.18-rc4-mm1 - time moving at 3x speed!
Date: Fri, 18 Aug 2006 12:24:11 +0200
User-Agent: KMail/1.9.3
Cc: Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060813012454.f1d52189.akpm@osdl.org> <200608181255.46999.ak@suse.de> <44E58FDC.6030007@aitel.hist.no>
In-Reply-To: <44E58FDC.6030007@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608181224.11303.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 18 August 2006 12:01, Helge Hafting wrote:
> Andi Kleen wrote:
> >> I have narrowed it down.  2.6.18-rc4 does not have the 3x time
> >> problem,  while mm1 have it.  mm1 without the hotfix jiffies
> >> patch is just as bad.
> >>     
> >
> > Can you narrow it down to a specific patch in -mm? 
> >   
> How do I do that?  Is -mm available through git somehow,
> or is there some other clever way?

You can download the broken-out version of the -mm and use quilt.

Quick start:
- unpack the tarball in a directory containing vanilla 2.6.18-rc4 sources,
- rename 'broken-out' to 'patches'
- use 'quilt push n' to apply the next n patches,
- use 'quilt pop n' to revert the last n patches applied,
- 'quilt applied | wc' gives you the number of patches currently applied,
- 'quilt top' returns the name of the last patch applied.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
