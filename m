Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275341AbTHNSi5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 14:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275345AbTHNSi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 14:38:56 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:61312 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275341AbTHNSi1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 14:38:27 -0400
Date: Thu, 14 Aug 2003 19:38:06 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Matt Wilson <msw@redhat.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] revert zap_other_threads breakage, disallow CLONE_THREAD without CLONE_DETACHED
Message-ID: <20030814183806.GA11703@mail.jlokier.co.uk>
References: <20030814182757.GA11623@mail.jlokier.co.uk> <Pine.LNX.4.44.0308141130300.1692-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308141130300.1692-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I've pushed the change to the BK trees, and if you're not a BK user you
> can just test the attached patch directly to see if it affects you..

That's cool, I am not affected.

Simply the documentation you mentioned, I felt someone who writes code
using CLONE_THREAD in future should be aware that if they just use
CLONE_THREAD by itself, their code won't work as expected with the
later 2.5 kernels.  The EINVAL ensures that perfectly.  So, :)

-- Jamie
