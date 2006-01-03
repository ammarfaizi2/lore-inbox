Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWACFbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWACFbk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 00:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWACFbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 00:31:40 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:59035 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751163AbWACFbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 00:31:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=COyWGglb7LUAChbyrd/UxZaOZur01DmsRnL3HO9NXFUioVTph/letnr0dAePoWjJL0kfZlbsLPtL3dgQCvPTXHwOvZtXNoKCGsEteJ6ZYwG3ESaLOK6I8OPmyJ7qwwcRwxf0ZydExdkO7FceHOVky39kQZqDliXW2dW8bvBJryM=  ;
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Ingo Molnar <mingo@elte.hu>,
       tim@physik3.uni-rostock.de, arjan@infradead.org, torvalds@osdl.org,
       davej@redhat.com, lkml <linux-kernel@vger.kernel.org>, mpm@selenic.com
In-Reply-To: <20060102102824.4c7ff9ad.akpm@osdl.org>
References: <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
	 <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org>
	 <20051229224839.GA12247@elte.hu>
	 <1135897092.2935.81.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
	 <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
	 <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
	 <20060102103721.GA8701@elte.hu> <20060102134228.GC17398@stusta.de>
	 <20060102102824.4c7ff9ad.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 16:31:02 +1100
Message-Id: <1136266262.5261.45.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-02 at 10:28 -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:

> > We only disagree on how to achieve an improvement.
> > 
> 
> The best approach is to manually review and fix up all the inline statements.
> 

I agree with this. Turning off inlining in one big hit can punish
correct users of inline and may cause regressions.

Reducing inline abuse seems to be the easist possible case for
incremental patches, which is how we've always tried to do things.
Andrew (and others) have been reducing inlines for years and things
are going along in the right direction.

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
