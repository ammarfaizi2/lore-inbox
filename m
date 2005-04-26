Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVDZDYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVDZDYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 23:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVDZDYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 23:24:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17853 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261201AbVDZDYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 23:24:15 -0400
Date: Tue, 26 Apr 2005 04:24:30 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Dittmer <jdittmer@ppp0.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050426032430.GR13052@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <42676B76.4010903@ppp0.net> <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be> <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk> <20050421175723.GB13052@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.62.0504252113160.26096@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504252113160.26096@numbat.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 09:14:01PM +0200, Geert Uytterhoeven wrote:
> On Thu, 21 Apr 2005, Al Viro wrote:
> > As far as I can see that's the minimally intrusive header changes needed
> > to avoid problems - better than variant with splitting sched.h as in m68k CVS.
> 
> We can discuss about that. IIRC, HCH is also in favor of splitting off struct
> task_struct from sched.h.

Sure, but splitting sched.h is a separate story.  Mixing it with m68k
merge will only make both harder.  It requires more include reordering
and I'd rather keep that headache separate from m68k issues.  I agree
that eventual splitup of sched.h makes sense.  However, I think that
going for minimally intrusive variant of merge and then dealing with
sched.h would be easier for everyone.
