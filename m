Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbUBEDiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 22:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbUBEDiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 22:38:17 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:39097 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265113AbUBEDiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 22:38:03 -0500
Date: Thu, 5 Feb 2004 09:13:20 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Janet Morgan <janetmor@us.ibm.com>, daniel@osdl.org, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.2-rc3-mm1] DIO read race fix
Message-ID: <20040205034320.GB3319@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1071190292.1937.13.camel@ibm-c.pdx.osdl.net> <20031230045334.GA3484@in.ibm.com> <1072830557.712.49.camel@ibm-c.pdx.osdl.net> <20031231060956.GB3285@in.ibm.com> <1073606144.1831.9.camel@ibm-c.pdx.osdl.net> <20040109035510.GA3279@in.ibm.com> <1075945198.7182.46.camel@ibm-c.pdx.osdl.net> <20040204180754.28801410.akpm@osdl.org> <4021B07E.8030700@us.ibm.com> <20040204191921.62122c15.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204191921.62122c15.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 07:19:21PM -0800, Andrew Morton wrote:
> Janet Morgan <janetmor@us.ibm.com> wrote:
> >
> > >Daniel McNeil <daniel@osdl.org> wrote:
> >  >  
> >  >
> >  >>I have found (finally) the problem causing DIO reads racing with
> >  >>buffered writes to see uninitialized data on ext3 file systems 
> >  >>(which is what I have been testing on).
> >  >>    
> >  >>
> >  >
> >  >What kernel?  If -mm, is this the only remaining buffered-vs-direct
> >  >problem?
> >  >
> >  >  
> >  >
> >  I think there was consensus on two other patches along the way:
> > 
> >      http://marc.theaimsgroup.com/?l=linux-kernel&m=107286971311559&w=2
> >      http://marc.theaimsgroup.com/?l=linux-aio&m=107291089712224&w=2
> 
> Yes, I think those are needed but this thing has been dragging on for so
> long it has become a little unclear.  This was the main reason why I backed
> off the fs-aio patches.
> 
> Daniel, could you please work out whether we actually need those patches
> and if so, prep them for us?  Presumably if ext2 passes all testing without
> those patches, we do not need them.

I think we agreed from a logical standpoint that those patches are correct
and needed, didn't we ?

Whether or not we encounter those races in our testing is to a certain
extent a matter of chance. I wouldn't use passing of all tests for ext2 
as a proof that they aren't needed. It just tells us that they may be
less likely.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

