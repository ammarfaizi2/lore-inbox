Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265452AbTL2Xnr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 18:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265461AbTL2Xnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 18:43:47 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:47091 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265452AbTL2Xno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 18:43:44 -0500
Date: Mon, 29 Dec 2003 15:41:40 -0800
To: Christoph Hellwig <hch@infradead.org>, Pat Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
Message-ID: <20031229234140.GA29575@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
References: <20031220122749.A5223@infradead.org> <Pine.SGI.3.96.1031222204757.20064A-100000@fsgi900.americas.sgi.com> <20031228143603.A20391@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228143603.A20391@infradead.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 02:36:03PM +0000, Christoph Hellwig wrote:
>  - no change in 000-hwgfs-update.patch.inprogress, hwgraph_path_lookup
>    shall not be reintroduced.

Pat, it looks like hwgraph_path_lookup() is only used in the PCI hotplug
code, and is messed up anyway (it's looking for a SCSI controller??), so
we can probably kill the addition of that function.

>  - 014-cleanup-pci.c.patch:  no change apparently?

Yeah, it would be nice to avoid introducing stuff that just gets deleted
in later patches.

>  - 030-pciio-cleanup.patch: Dito

Not sure what this is about...

>  - 071-xswitch.devfunc.patch: Dito.

Yes, I think we do have more xswitches coming...

>  - 075-rename-reorg.patch: Dito

If this stuff is going to be used by more than just ia64, it should
probably be moved to another directory/file.

> > David or Andrew can you take these patches ?
> 
> Really, that's not what I consider fixing.  Please fix up
> 000,014 and 030 and drop 071 and 075, then it should be fine for
> merging.  071 shouldn't go in at all and 075 needs the renaming killed,
> everything else can go in although it's not nice.

Pat, will the patches work if we omit 071 and 075?  If so, maybe we can
get the others merged in and continue to work on the last two.

Jesse
