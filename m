Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWCGDeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWCGDeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWCGDeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:34:16 -0500
Received: from cantor2.suse.de ([195.135.220.15]:20129 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932482AbWCGDeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:34:16 -0500
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com
Subject: Re: Ocfs2 performance bugs of doom
References: <4408C2E8.4010600@google.com>
	<20060303233617.51718c8e.akpm@osdl.org> <440B9035.1070404@google.com>
	<20060306025800.GA27280@ca-server1.us.oracle.com>
	<440BC1C6.1000606@google.com>
	<20060306195135.GB27280@ca-server1.us.oracle.com>
From: Andi Kleen <ak@suse.de>
Date: 07 Mar 2006 04:34:12 +0100
In-Reply-To: <20060306195135.GB27280@ca-server1.us.oracle.com>
Message-ID: <p733bhvgc7f.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh <mark.fasheh@oracle.com> writes:

> On Sun, Mar 05, 2006 at 08:59:50PM -0800, Daniel Phillips wrote:
> > So that hack apparently improves the bucket distribution quite a bit, but
> > look, the bad old linear systime creep is still very obvious.  For that
> > there is no substitute for lots of buckets.
> Yes, I think the way to go right now is to allocate an array of pages and
> index into that. We can make the array size a mount option so that the
> default can be something reasonable ;)

Did you actually do some statistics how long the hash chains are? 
Just increasing hash tables blindly has other bad side effects, like
increasing cache misses.

-Andi
