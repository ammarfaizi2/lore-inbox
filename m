Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275362AbTHMUDq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275374AbTHMUDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:03:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:14780 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S275369AbTHMUDn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:03:43 -0400
Date: Wed, 13 Aug 2003 14:06:41 -0700 (PDT)
From: Ram Pai <linuxram@us.ibm.com>
X-X-Sender: ram@localhost
Reply-To: linuxram@us.ibm.com
To: Suparna Bhattacharya <suparna@in.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Badari Pulavarty <pbadari@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <linux-aio@kvack.org>
Subject: Re: [PATCH][2.6-mm] Readahead issues and AIO read speedup
In-Reply-To: <20030808135645.GA3430@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0308131253460.2026-100000@localhost>
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran an Database workload on the test3-mm1 bits and got around 20% 
improvement.  These bits have Suparna's readahead_patch. 

The number of 4k read requests sent to the driver reduced significantly by
95%. Effectively generating lesser number of larger-size read-requests.

And the number of readahead-window-resets dropped down by 50%.

FYI,
Ram Pai

On Fri, 8 Aug 2003, Suparna Bhattacharya wrote:

> On Thu, Aug 07, 2003 at 01:58:19PM -0700, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> > > On Thursday 07 August 2003 10:39 am, Andrew Morton wrote:
> > >  > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >  > > We should do readahead of actual pages required by the current
> > >  > > read would be correct solution. (like Suparna suggested).

-- 
Ram Pai
linuxram@us.ibm.com
----------------------------------




