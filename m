Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbTDPTnH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 15:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264570AbTDPTnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 15:43:07 -0400
Received: from twister.ispgateway.de ([62.67.200.3]:15883 "HELO
	twister.ispgateway.de") by vger.kernel.org with SMTP
	id S264569AbTDPTnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 15:43:07 -0400
Date: Wed, 16 Apr 2003 21:56:14 +0200
From: Steffen Moser <lists@steffen-moser.de>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x Problem with cd writing
Message-ID: <20030416195614.GC9662@steffen-moser.de>
Mail-Followup-To: Michael Buesch <fsdeveloper@yahoo.de>,
	linux-kernel@vger.kernel.org
References: <200304161919.08615.fsdeveloper@yahoo.de> <20030416181005.GB9662@steffen-moser.de> <200304162058.29367.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304162058.29367.fsdeveloper@yahoo.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* On Wed, Apr 16, 2003 at 08:58 PM (+0200), Michael Buesch wrote:
> On Wednesday 16 April 2003 20:10, Steffen Moser wrote:
> > * On Wed, Apr 16, 2003 at 07:19 PM (+0200), Michael Buesch wrote:
> > > While my writer writes TOC or fixes CD (doesn't write real data-stream),
> > > the whole ide-disk interface of the system is frozen.
> >
> > Are you sure that the whole IDE subsystem freezes? I suppose that only
> > the IDE channel where the CD writer is connected to becomes frozen
> No, both channels are frozen.

So this might be a different problem. Here, only the secondary IDE
channel was blocked because the CD writer was connected to this channel. 

> > You can try the option "-immed" which is available at least when using
> > "cdrecord-2.0" [1].
> sorry, doesn't work.

I think that's one more hint that you're experiencing a different kind
of problem. This option worked for me (as well as connecting the CD
writer to a separate IDE channel which is not shared with any other
device - especially with a hard disk).

Steffen
