Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbWEaVkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWEaVkZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbWEaVkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:40:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54237 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965172AbWEaVkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:40:24 -0400
Date: Wed, 31 May 2006 14:43:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: mbligh@google.com, linux-kernel@vger.kernel.org, apw@shadowen.org,
       ak@suse.de
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060531144310.7aa0e0ff.akpm@osdl.org>
In-Reply-To: <447E093B.7020107@mbligh.org>
References: <447DEF49.9070401@google.com>
	<20060531140652.054e2e45.akpm@osdl.org>
	<447E093B.7020107@mbligh.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> Andrew Morton wrote:
> > Martin Bligh <mbligh@google.com> wrote:
> > 
> >>The x86_65 panic in LTP has changed a bit. Looks more useful now.
> >>Possibly just unrelated new stuff. Possibly we got lucky.
> > 
> > What are you doing to make this happen?
> 
> runalltests on LTP
> 

We have to get to the bottom of this - there's a shadow over about 500
patches and we don't know which.

iirc I tried to reproduce this a couple of weeks back and failed.

Are you able to narrow it down to a particular LTP test?  It was mtest01 or
something like that?  Perhaps we can identify a particular command line
which triggers the fault in a standalone fashion?

And why can't I make it happen?  Perhaps it's a memory initialisation
problem, and it only happens to hit in that stage of LTP because that's
when you started doing page reclaim, or something?  Perhaps just
try putting a heap of memory pressure on the machine, see what
that does?

Being unable to reproduce it and not having a theory to go on leaves us
kinda stuck.  Help, please?
