Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVERI5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVERI5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 04:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVERI5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 04:57:39 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:7648 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262048AbVERI5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 04:57:34 -0400
Date: Wed, 18 May 2005 14:37:22 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, gregoire.favre@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050518090722.GA3937@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050516085832.GA9558@gmail.com> <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org> <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com> <1116354894.4989.42.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116354894.4989.42.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 01:34:53PM -0500, James Bottomley wrote:
> The root cause, I think, is that the aic7xxx isn't starting out at async
> narrow for the first inquiry (because the original DV code I removed did
> this, and I didn't add an equivalent back).  The latest aic7xxx patch
> should sort this out.
> 
> So, to get all of these changes, could you start with vanilla linus
> kernel 2.6.12-rc4 (or tree based on this, but not -mm which already has
> some of the SCSI tree included) and then apply the SCSI patch at
> 
> http://parisc-linux.org/~jejb/scsi_diffs/scsi-misc-2.6.diff
> 
> and see if it works?

It works !! Thanks.

So are these patches getting into -mm first or -rc5 ??

	-Dinakar
