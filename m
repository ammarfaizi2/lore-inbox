Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSILSav>; Thu, 12 Sep 2002 14:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSILSau>; Thu, 12 Sep 2002 14:30:50 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:55791 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317063AbSILSat>; Thu, 12 Sep 2002 14:30:49 -0400
Date: Thu, 12 Sep 2002 14:35:40 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Linux Aio <linux-aio@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 port of aio-20020619 for raw devices
Message-ID: <20020912143540.J18217@redhat.com>
References: <3D80DB14.2040809@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D80DB14.2040809@watson.ibm.com>; from nagar@watson.ibm.com on Thu, Sep 12, 2002 at 02:21:08PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 02:21:08PM -0400, Shailabh Nagar wrote:
> I just did a rough port of the raw device part of the aio-20020619.diff
> over to 2.5.32 using the 2.5 aio API published so far. The changeset
> comments are below. The patch hasn't been tested. Its only guaranteed
> to compile.
> 
> I'd like to reiterate that this is not a fork of aio kernel code
> development or any attempt to question Ben's role as maintainer ! This
> was only an exercise in porting to enable a comparison of the older
> (2.4) approach with whatever's coming soon.
> 
> Comments are invited on all aspects of the design and implementation.

The generic aio <-> kvec functions were found to not work well, and 
the chunking code needs to actually pipeline data for decent io thruput.  
Short story: the raw device code must be rewritten using the dio code 
that akpm introduced.

		-ben
