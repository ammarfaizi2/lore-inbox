Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWERLxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWERLxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 07:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWERLxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 07:53:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60829 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750737AbWERLxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 07:53:25 -0400
Subject: Re: [RFC: 2.6 patch] fs/jbd/journal.c: possible cleanups
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Tweedie <sct@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060516125053.03dc1d8f.akpm@osdl.org>
References: <20060516174413.GI10077@stusta.de>
	 <20060516122731.6ecbdeeb.akpm@osdl.org> <20060516193956.GS10077@stusta.de>
	 <20060516125053.03dc1d8f.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 18 May 2006 12:52:13 +0100
Message-Id: <1147953133.5464.64.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-05-16 at 12:50 -0700, Andrew Morton wrote:

> Still, the jbd API is exported for other filesystems to use.  If these
> functions are considered part of that API (they are) then I'd suggest that
> they should be exported.

Agreed.

Note that on ext2-devel there has been a huge amount of activity over
the past month to get extents, and >32-bit block addressing, ready for
ext3.  One of the things needed for that is a new jbd-level feature for
64-bit capability, so ext3 is going to need more dynamic access to the
jbd feature bits soon.  This is definitely not the right time to be
removing feature access from the API!

--Stephen


