Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTLKXFc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 18:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264416AbTLKXFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 18:05:32 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:65519 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264415AbTLKXFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 18:05:25 -0500
Date: Thu, 11 Dec 2003 15:05:11 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mem: and Swap: lines in /proc/meminfo
Message-ID: <20031211230511.GI15401@matchmail.com>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20031211222311.GH15401@matchmail.com> <Pine.LNX.4.44.0312111741150.15419-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312111741150.15419-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 05:42:46PM -0500, Rik van Riel wrote:
> On Thu, 11 Dec 2003, Mike Fedyk wrote:
> 
> > Inact_dirty:     21516 kB
> > Inact_laundry:   65612 kB
> > Inact_clean:     19812 kB
> > 
> > These three are seperate lists in rmap, and are equal to "Inactive:" in
> > the -aa vm.
> 
> I should add an Inactive: list to -rmap that sums up all
> 3, to make it a bit easier on programs parsing /proc.
> 

ISTR, asking for this a while ago ;)

Yes, please do add that Inactive: line to rmap. :)

> Note that the inactive clean pages count (more or less)
> as free pages, too.
> 

But I should count it as "Inactive" right?

So, if it's clean, then the page has already been zeroed out, and is ready
to be used but just needs some flags updated?  Or they contain possibly
useful data, and just are not dirty?  So a page that is inactive, but not
dirty will go directly in that list?

What can happen to Inact_clean pages besides being freed, and used on the
free memory list?

> > Inact_target:   150080 kB
> > 
> > This doesn't account any memory, but is only what the VM is trying to size
> > the sum of the three lists above.
> > 
> > Do I have that right?
> 
> Yes, you're completely right.

Great. :)
