Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbUCHJOT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 04:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUCHJOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 04:14:19 -0500
Received: from gprs40-191.eurotel.cz ([160.218.40.191]:57766 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262297AbUCHJOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 04:14:17 -0500
Date: Mon, 8 Mar 2004 10:13:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Some highmem pages still in use after shrink_all_memory()?
Message-ID: <20040308091324.GA209@elf.ucw.cz>
References: <20040307144921.GA189@elf.ucw.cz> <20040307164052.0c8a212b.akpm@osdl.org> <20040308063639.GA20793@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308063639.GA20793@hexapodia.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 08-03-04 00:36:39, Andy Isaacson wrote:
> On Sun, Mar 07, 2004 at 04:40:52PM -0800, Andrew Morton wrote:
> > Pavel Machek <pavel@ucw.cz> wrote:
> > > For swsusp, I need to free as much memory as possible. Well, and it
> > > would be great if no highmem pages remained, so that I would not have
> > > to deal with that. Is that possible?
> > 
> > No, it isn't.  There are pagetable pages and mlocked user pages which we
> > cannot do anything with.
> > 
> > We could perhaps swap out the mlocked pages anyway if a suspend is in
> > progress, but the highmem pagetable pages are not presently reclaimed
> > by the VM.
> 
> Note that there are some applications for which it is a *bug* if an
> mlocked page gets written out to magnetic media.  (gpg, for example.)

Well, but that can not be solved. During suspend-to-disk, data (by
definition) go to magnetic media. We could block suspend, and we could
kill such application....
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
