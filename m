Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbUCPAmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUCPASH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:18:07 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:5133 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262886AbUCPAJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:09:08 -0500
Date: Tue, 16 Mar 2004 00:09:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
Message-ID: <20040316000906.A24435@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Johannes Erdfelt <johannes@erdfelt.com>,
	linux-kernel@vger.kernel.org
References: <1AC79F16F5C5284499BB9591B33D6F000B4805@orsmsx408.jf.intel.com> <20040315231705.A23888@infradead.org> <20040315234425.GD30801@sventech.com> <20040315234826.A24238@infradead.org> <20040315235414.GE30801@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040315235414.GE30801@sventech.com>; from johannes@erdfelt.com on Mon, Mar 15, 2004 at 03:54:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 03:54:14PM -0800, Johannes Erdfelt wrote:
> > Did you actually read it?
> 
> The code on openib.org? Yes, I wrote some of it.
> 
> I would be the first to say that there are portions that need to be
> rewritten, but I definately do not think all or even most of it does.
> 
> That's why I was asking what specifically you found fatally wrong with
> it. I haven't seen many critiques, so I can only assume it's the same
> things I see wrong with it.

Start with the thing Robert already mentioned.  Ad ontop of that:

 - the horrible Winodes/Linux compat code.  We all know this kind
   of compat code is messy.  But the way it's don in this code is just
   incredibly idiotic.
 - totally braindead use of macro abstraction
 - those split into far too many files
 - wrong use of dma mapping abstraction
 - braindead malloc code
 - wrong modversions handling duplicated in every file

I'm really surprised you're admitting to having touched that code.
I'd have guessed everyone who did would hide in his house ashamed.

> > p.s.  if you reply to my mails please keep me in the To line.  Really,
> > please don't do any fany reply to group tricks unless people explicitly
> > request it in the Mail-Fup header.
> 
> If you really want duplicates of all the replies, sure, I'll make an
> exception for you.
> 
> I don't see why a smarter client, or mail filter, couldn't do the same
> thing without depending on the behaviour of the sender.

Replying to people personally is good taste.  You might know I'm on
lkml but on many other lists I'm not.  As are other people on lkml.
A filter can easily filter out duplicates but it can't magically
create copies of mails not addressed to you. 

In addition I tend to read my inbox fairly quick all the time and
the lkml mailbox only when I'm at least a little idle.
