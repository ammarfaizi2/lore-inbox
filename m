Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbTINRag (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 13:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbTINRag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 13:30:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16360 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261256AbTINRae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 13:30:34 -0400
Message-ID: <3F64A5AC.8020901@pobox.com>
Date: Sun, 14 Sep 2003 13:30:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
References: <1063484193.1781.48.camel@mulgrave> <20030913212723.GA21426@gtf.org> <20030914181201.E3371@pclin040.win.tue.nl>
In-Reply-To: <20030914181201.E3371@pclin040.win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> Such things are infinitely difficult.
> Moreover, great care is needed - one has to define precisely what it
> is this GUID is supposed to be an ID of.

Absolutely agreed.


> (Is it the ZIP drive? Or is it the ZIP disk?
> The 2.4 USB code is broken because it remembers a GUID and thinks that
> identical GUID implies identical disk.)
> 
> I have a handful of CF/SM cardreaders.
> Some of them have no form of ID. Others have an ID.
> 
> Then one can insert a CF or SM card into the reader.
> Some of these cards have an ID. Some have not.
> 
> On the card one usually finds a FAT filesystem.
> There may be a label. Or there may not be.
> 
> This describes a 3-level situation.
> I have also 4-level situations, where the reader is filled with
> one of four auxiliary adapters (each with an own ID) and the
> adapter then get a CF/SM/SD/... card.

Using an adapter's ID would be a mistake.  You want to use the media's 
unique ID, assuming it has one.


> So, yes, we love IDs. And we can always provide them ourselves
> as label or UUID or so in the filesystem.

Not all filesystems have them :)

Further, some sites may prefer block-level GUIDs to fs-level ones. 
Sites using raw partitions instead of filesystems, for one.

We must leave this up to the sysadmin -- within the bounds of technology 
of course.  The sysadmin is out of luck if they purchase a media that 
does not support some sort of labelling or UUID.


> But finding an unformatted unlabeled disk is difficult.

You sound like you're agreeing with me ;-)

	Jeff



