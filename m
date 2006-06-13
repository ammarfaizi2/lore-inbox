Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWFMRLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWFMRLL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 13:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWFMRLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 13:11:11 -0400
Received: from smtp-out.google.com ([216.239.45.12]:48146 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932203AbWFMRLJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 13:11:09 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=ID6lOYhgiZh5SyWrEbKfhrRLhqAB94tLDem/P5Lu0YGK6OYk24duTbQsoZHZJAscg
	glgXlbn/d7qX/ZnR9LQyw==
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of
	physical_pages_backing it
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Linux-mm@kvack.org, arjan@infradead.org,
       jengelh@linux01.gwdg.de
In-Reply-To: <200606130756.52669.ak@suse.de>
References: <787b0d920606122253o4f1a9e18x1ca49c3ce005696f@mail.gmail.com>
	 <200606130756.52669.ak@suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Tue, 13 Jun 2006 10:10:36 -0700
Message-Id: <1150218637.9576.73.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 07:56 +0200, Andi Kleen wrote:
> On Tuesday 13 June 2006 07:53, Albert Cahalan wrote:
> > Quoting two different people:
> > 
> > > BTW, what is smaps used for (who uses it), anyway?
> > ...
> > > smaps is only a debugging kludge anyways and it's
> > > not a good idea to we bloat core data structures for it.
> > 
> > I'd be using it in procps for the pmap command if it
> > were not so horribly nasty. I may eventually get around
> > to using it, but maybe it's just too gross to tolerate.
> 
> I agree it's pretty ugly.
> 
> But pmap I would consider a debugging kludge too - it should
> work when someone needs it, but it doesn't need to be particularly
> fast.
> 


Providing useful information about memory consumption is hardly
debugging kludge.  Quite unfortunately the rss part of the col is filled
with dashes at present.  This vma based counter will allow Albert to
print useful information w/o having to traverse the whole set of page
tables.

-rohit

