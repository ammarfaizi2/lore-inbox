Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTF3Mnf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 08:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTF3Mnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 08:43:35 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:9937 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262543AbTF3Mne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 08:43:34 -0400
Date: Mon, 30 Jun 2003 18:34:32 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.73-mm1 falling over in SDET
Message-ID: <20030630130432.GD4065@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030628170235.51ee2f69.akpm@digeo.com> <1056857338.2514.4.camel@mulgrave> <6620000.1056864944@[10.10.2.4]> <20030630101719.GC4065@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630101719.GC4065@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 03:47:19PM +0530, Maneesh Soni wrote:
> On Sun, Jun 29, 2003 at 06:09:41AM +0000, Martin J. Bligh wrote:
> > --James Bottomley <James.Bottomley@SteelEye.com> wrote (on Saturday, June 28, 2003 22:28:57 -0500):
> > 
> > > On Sat, 2003-06-28 at 19:02, Andrew Morton wrote:
> > >> Yes, isplinux_queuecommand() returns non-zero and the scsi generic layer
> > >> cheerfully goes infinitely recursive.
> > > 
> > > Sigh, certain persons need to be more careful when doing logic
> > > alterations.
> > > 
> > > Try the attached.
> > 
> > OK, that gets rather further, and I strongly suspect fixes the SCSI
> > problem. Thanks very much.
> > 
> > But now it just OOMs instead, which seems to be slab failing 
> > dismally to shrink it's fat ass enough to fit in that lazy-boy.
> > Ext2 doesn't look desparately happy either. Maybe it's really
> > that one's fault?
> > 
> 
> I tried sdet on 16-way numaq with 2.5.73-mm2. It completes the run on ext2 
> (no OOMs), but gives following oops while running on ext3
> 

Looks like that was some one off oops.. on second iteration I could run
sdet on ext3 also without any oops or oom.

Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
