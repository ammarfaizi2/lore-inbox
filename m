Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268915AbUIMUTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268915AbUIMUTC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268929AbUIMUTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:19:02 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:15086 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S268915AbUIMUSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:18:54 -0400
Date: Mon, 13 Sep 2004 22:18:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Tonnerre <tonnerre@thundrix.ch>
cc: Hugh Dickins <hugh@veritas.com>, Alex Zarochentsev <zam@namesys.com>,
       Paul Jackson <pj@sgi.com>, William Lee Irwin III <wli@holomorphy.com>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined
 atomic_sub_and_test
In-Reply-To: <20040913200359.GE19399@thundrix.ch>
Message-ID: <Pine.LNX.4.61.0409132212480.877@scrub.home>
References: <Pine.LNX.4.44.0409131545100.17907-100000@localhost.localdomain>
 <Pine.LNX.4.61.0409131731400.877@scrub.home> <20040913200359.GE19399@thundrix.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Sep 2004, Tonnerre wrote:

> On Mon, Sep 13, 2004 at 06:03:28PM +0200, Roman Zippel wrote:
> > +#define atomic_add_and_test(i,v) (atomic_add_return((i), (v)) == 0)
> > +#define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
> 
> This is no longer atomic, is it? I mean, there's no guarantee that the
> atomic_add_return   and   the    comparison   are   executed   without
> interruption, is there?

Only the read/write access needs to be atomic, when the comparison happens 
is irrelevant.

bye, Roman
