Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVA0F3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVA0F3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 00:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVA0F3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 00:29:04 -0500
Received: from holomorphy.com ([66.93.40.71]:51690 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262469AbVA0F3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 00:29:01 -0500
Date: Wed, 26 Jan 2005 21:28:56 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>, rmk@arm.linux.org.uk
Subject: Re: don't let mmap allocate down to zero
Message-ID: <20050127052856.GT10843@holomorphy.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> <20050126172538.GN10843@holomorphy.com> <20050127050927.GR10843@holomorphy.com> <20050127051855.GB24107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127051855.GB24107@redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 09:09:27PM -0800, William Lee Irwin III wrote:
>> There's a long discussion here, in which no one appears to have noticed
>> that SHLIB_BASE does not exist in mainline. Is anyone else awake here?

On Thu, Jan 27, 2005 at 12:18:56AM -0500, Dave Jones wrote:
> It's an exec-shield'ism. Rik likely was working off a Red Hat/Fedora
> kernel tree.

It does change things in a substantial way. Namely, the lower address
space boundary doesn't exist in mainline at all, and so its enforcement
requires introduction. Furthermore, mainline must concern itself with
all Linux-supported architectures (not distro-supported architectures),
not just ia32/x86-64, so there is also FIRST_USER_PGD_NR to take into
account as opposed to pulling magic ia32/x86-64 -specific numbers out
of a hat and splattering them all over core code. Not that you had
anything to do with any of this.


-- wli
