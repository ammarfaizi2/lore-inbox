Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbTHZOll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbTHZOhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:37:37 -0400
Received: from angband.namesys.com ([212.16.7.85]:10882 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261629AbTHZOfc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:35:32 -0400
Date: Tue, 26 Aug 2003 18:35:30 +0400
From: Oleg Drokin <green@namesys.com>
To: Christoph Hellwig <hch@lst.de>, marcelo@hera.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backport iget_locked from 2.5/2.6
Message-ID: <20030826143530.GD23462@namesys.com>
References: <20030825140714.GA17359@lst.de> <20030826112716.GA14680@namesys.com> <20030826134809.GA924@lst.de> <20030826135442.GB23462@namesys.com> <20030826143024.GA4184@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826143024.GA4184@lst.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Aug 26, 2003 at 04:30:24PM +0200, Christoph Hellwig wrote:
> > > Mail-Followup-To: Christoph Hellwig <hch@angband.namesys.com>,
> > Hm, very interesting header, I'd say. No wonder I'm getting errors replying to
> > your emails.
> Well, I got the same from you although I though only in the Cc line
> which I removed.

That's because I hit "reply" first time and have not looked at the CC list.

> > > > The patch below does not achieve this. We still fill inode private part
> > > > outside of inode_lock locked region.
> > > -ENOPATCH :)
> > I meant the patch in the email you sent and to which I answered originally ;)
> Sorry, I missed the 'not' when reading and though you had an alternate
> patch

Actually, I have altenate patch (but no, I have not tried to attach it) ;)
I have full iget5_locked backport (that I was sending around some time ago). Only it
will break every iget4 user not in the tree (by changing VFS API), so I guess it is not an option.
But if people think it is good idea to adapt this change, I can easily resurrect that patch, of course.

Bye,
    Oleg
