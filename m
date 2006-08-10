Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161240AbWHJM7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161240AbWHJM7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161242AbWHJM7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:59:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:56498 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161240AbWHJM7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:59:14 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: annotate the rest of entry.s::nmi
Date: Thu, 10 Aug 2006 14:58:45 +0200
User-Agent: KMail/1.9.3
Cc: "Jan Beulich" <jbeulich@novell.com>, linux-kernel@vger.kernel.org,
       stsp@aknet.ru
References: <200608100851_MC3-1-C7A8-8B6A@compuserve.com>
In-Reply-To: <200608100851_MC3-1-C7A8-8B6A@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608101458.45683.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 14:48, Chuck Ebbert wrote:
> In-Reply-To: <44DB0927.76E4.0078.0@novell.com>
> 
> On Thu, 10 Aug 2006 10:23:35 +0200, Jan Beulich wrote:
> 
> > >Part of the NMI handler is missing annotations.  Just moving
> > >the RING0_INT_FRAME macro fixes it.  And additional comments
> > >should warn anyone changing this to recheck the annotations.
> > 
> > I have to admit that I can't see the value of this movement; the
> > code sequence in question was left un-annotated intentionally.
> > The point is that the push-es in FIX_STACK() aren't annotated, so
> > things won't be correct at those points anyway.
> 
> I have a patch here that adds that, but it won't compile
> because that part of the NMI handler is un-annotated:

Ok i dropped the original patch for now and you guys can work
out a correct fix.

-Andi
