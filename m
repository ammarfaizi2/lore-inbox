Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWALOdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWALOdy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWALOdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:33:54 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:45346 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030417AbWALOdx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:33:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B3OEDazfzJXuhiqQYScpDmKSm0cOHFeq/8n19TYp6g4kbENbslUumh3RvKr00ywhRbU+yShPdCqA8pHn+DssVqZulmQxbCBIHW94pgzRGg35w8JtdksgiG6aqLwU9GsFdY7nCthArHkOOdfHOHCSlIqSNNbXmcpYgiYZLVqDpik=
Message-ID: <728201270601120633i1c9072fp3329d05b49de790f@mail.gmail.com>
Date: Thu, 12 Jan 2006 08:33:51 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: Back to the Future ? or some thing sinister ?
Cc: Nathan Lynch <ntl@pobox.com>, Chaitanya Hazarey <cvh.tcs@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1137016986.2890.57.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <eaef64fc0601081131i17336398l304038c6dea3e057@mail.gmail.com>
	 <20060109040322.GA2683@localhost.localdomain>
	 <1137016986.2890.57.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/06, john stultz <johnstul@us.ibm.com> wrote:
> On Sun, 2006-01-08 at 22:03 -0600, Nathan Lynch wrote:
> > Chaitanya Hazarey wrote:
> > >
> > > We have got a machine, lets say X , make is IBM and the CPU is Intel
> > > Pentium 4 2.60 GHz. Its running a 2.6.13.1 Kernel and previously,
> > > 2.6.27-4 Kernel the distribution is Debian Sagre.

It may be BIOS related. But I feel it might be an overflow related
issue. If the variable is signed int then there will be a transition
from 0x7fffffff ns  to 0x80000000 ns which is basically from +2 sec to
-2 sec which will result in 4 sec loss.

Ram
