Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266900AbUHCWVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266900AbUHCWVN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 18:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266882AbUHCWVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 18:21:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:9684 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266853AbUHCWVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 18:21:11 -0400
To: Rik van Riel <riel@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [patch] mlock-as-nonroot revisted 
In-reply-to: Your message of Tue, 03 Aug 2004 17:31:08 EDT.
             <Pine.LNX.4.44.0408031729100.5948-100000@dhcp83-102.boston.redhat.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26283.1091571485.1@us.ibm.com>
Date: Tue, 03 Aug 2004 15:18:05 -0700
Message-Id: <E1Bs7bj-0006pz-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Aug 2004 17:31:08 EDT, Rik van Riel wrote:
> On Tue, 3 Aug 2004, Andrea Arcangeli wrote:
> 
> > I agree there aren't security issues, but it's still very wrong to
> > charge the old user if the admin gives the locked ram to a new user.
> > This erratic behaviour shows how much the rlimit approch is flawed for
> > named fs objects that have nothing to do with the transient task that
> > created them.
> 
> If root wants to screw over a user, there's nothing we
> can do.  I am not worried about the scenario you describe
> because hugetlbfs seems to be used only by Oracle anyway,
> so you won't run into issues like you describe.
> 
> It would be different for a general purpose filesystem,
> but I'd like to see a usage case for your scenario before
> making the code overly complex.

DB2, JVM also use hugetlbfs, other uses have been tried with
some success.

gerrit
