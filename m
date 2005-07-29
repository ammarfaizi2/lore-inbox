Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVG2VXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVG2VXU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVG2VVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:21:19 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:44825 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262654AbVG2VS2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:18:28 -0400
Date: Fri, 29 Jul 2005 23:19:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: vmlinux.lds.S Distinguish absolute symbols
Message-ID: <20050729211954.GA8263@mars.ravnborg.org>
References: <m1u0id1k47.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u0id1k47.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 01:35:04PM -0600, Eric W. Biederman wrote:
> Currently in the linker script we have several labels
> marking the beginning and ending of sections that
> are outside of sections, making them absolute symbols.

They are outside the sections for a very specific reason.
If moved inside the section they sometimes got unexpected values due to
the alignment that ld impose on the section itself.

I recall that when Kai Germaschewski long time ago started the
unification of the vmlinux.lds files some people had boot problems
exactly because the label was defined inside the section and therefore
ld caused it to have another value as if it was placed outside the
section.

I no longer recall the precise details of what happened.
Google may help you...

	Sam
