Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269603AbUIRR5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269603AbUIRR5T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 13:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269584AbUIRR5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 13:57:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38623 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269130AbUIRR5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 13:57:16 -0400
Date: Sat, 18 Sep 2004 18:57:14 +0100
From: Matthew Wilcox <willy@debian.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, pj@sgi.com,
       linux-scsi@vger.kernel.org, mdr@cthulhu.engr.sgi.com,
       jeremy@cthulhu.engr.sgi.com, djh@cthulhu.engr.sgi.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Documentation/io_ordering.txt is wrong
Message-ID: <20040918175714.GD642@parcelfarce.linux.theplanet.co.uk>
References: <20040917183029.GW642@parcelfarce.linux.theplanet.co.uk> <20040918061001.GC21456@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040918061001.GC21456@colo.lackof.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2004 at 12:10:01AM -0600, Grant Grundler wrote:
> Jesse Barnes wrote:
> ...
> > Btw Andrew (Vasquez), there's a small doc I put together that should describe 
> > when you have to worry about PCI posting.  It's in the tree:  
> > Documentation/io_ordering.txt.  If it's incomplete or confusing, just let me 
> > know and I'll update it.
> 
> Jesse,
> Both. incomplete and confusing.
> "concrete example of a hypothetical driver" wasn't my first warning
> this document needed work. :^)

Not just incomplete and confusing, but actively wrong.  spin_lock/
spin_unlock should imply ordering of readb().  What you're describing
there is __readb().  See Documentation/DocBook/deviceiobook.tmpl.  Also,
rmb() should ensure ordering of io reads; there should be no need to
touch the device.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
