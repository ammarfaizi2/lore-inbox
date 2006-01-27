Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWA0MQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWA0MQd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 07:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWA0MQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 07:16:33 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:39386 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932471AbWA0MQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 07:16:33 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 00/23] [Suspend2] Freezer Upgrade Patches
Date: Fri, 27 Jan 2006 13:18:01 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601270010.22702.rjw@sisk.pl> <200601271404.08680.nigel@suspend2.net>
In-Reply-To: <200601271404.08680.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601271318.01985.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 27 January 2006 05:04, Nigel Cunningham wrote:
> On Friday 27 January 2006 09:10, Rafael J. Wysocki wrote:
> > On Thursday, 26 January 2006 04:45, Nigel Cunningham wrote:
> > > Hi everyone.
> > >
> > > This set of patches represents the freezer upgrade patches from Suspend2.
> > >
> > > The key features of this changeset are:
> > >
> > > - Use of Christoph Lameter's todo list notifiers, which help with SMP
> > >   cleanness.
> > > - Splitting the freezing of kernel and userspace processes. Freezing
> > >   currently suffers from a race because userspace processes can be
> > >   submitting work for kernel threads, thereby stopping them from
> > >   responding to freeze messages in a timely manner. The freezer can
> > >   thus give up when it doesn't really need to. (This is not normally
> > >   a problem only because load is not usually high).
> >
> > Could you please describe specific situation?
> 
> The simplest example would be:
> 
> dd if=/dev/hda of=/dev/null
> echo disk > /sys/power/state

Well, I don't think it's a usual kind of workload. :-)

Anyway, could you please give some details?  I mean how exactly your patch
helps in this particular case?

Greetings,
Rafael
 
