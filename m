Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTLKWXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 17:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTLKWXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 17:23:19 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:53192 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S263775AbTLKWXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 17:23:17 -0500
Date: Thu, 11 Dec 2003 14:23:11 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mem: and Swap: lines in /proc/meminfo
Message-ID: <20031211222311.GH15401@matchmail.com>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20031209000021.GA8402@mis-mike-wstn.matchmail.com> <Pine.LNX.4.44.0312111701330.15419-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312111701330.15419-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 05:02:01PM -0500, Rik van Riel wrote:
> On Mon, 8 Dec 2003, Mike Fedyk wrote:
> 
> > Now I need to change the order (it is using Mem: and Swap: first, and the
> > other more thurough method second), but I'm wondering what versions of the
> > kernel I'd be cutting out if I just removed the parsing of Mem: and Swap:...
> 
> IIRC 2.2 kernels already had the one-value-per-line
> memory statistics, so you'd only lose 2.0 and earlier.

Ahh, great.  I'll change the ordering.  Should help clean up the code a bit
and make adding the features I want easier. :)

Another question:

Inact_dirty:     21516 kB
Inact_laundry:   65612 kB
Inact_clean:     19812 kB

These three are seperate lists in rmap, and are equal to "Inactive:" in the
-aa vm.

Inact_target:   150080 kB

This doesn't account any memory, but is only what the VM is trying to size
the sum of the three lists above.

Do I have that right?

I'm going to graph active and inactive for lrrd, and I need to know how to
map the different values when it is run on a rmap kernel.

Thanks.
