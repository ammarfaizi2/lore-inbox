Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbWGFDKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWGFDKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 23:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWGFDKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 23:10:23 -0400
Received: from xenotime.net ([66.160.160.81]:11951 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965143AbWGFDKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 23:10:22 -0400
Date: Wed, 5 Jul 2006 20:13:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Thomas Tuttle <thinkinginbinary@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Create new LED trigger for CPU activity (ledtrig-cpu)
 (UPDATED)
Message-Id: <20060705201307.93050bb6.rdunlap@xenotime.net>
In-Reply-To: <20060706030337.GC25835@phoenix>
References: <e4cb19870607051948t7e6d208m729a572a65f2da5e@mail.gmail.com>
	<20060705200126.48f83ec0.rdunlap@xenotime.net>
	<20060706030337.GC25835@phoenix>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 23:03:37 -0400 Thomas Tuttle wrote:

> On July 05 at 23:01 EDT, Randy.Dunlap hastily scribbled:
> > On Wed, 5 Jul 2006 22:48:17 -0400 Thomas Tuttle wrote:
> > 
> > > Here is a new version of the patch, incorporating code style tips from
> > > Randy Dunlap <rdunlap@xenotime.net>, and based on 2.6.17-git25, rather
> > > than 2.6.17.1.
> > > 
> > > I noticed that there's a Heartbeat LED trigger in the git version.  I
> > > hope this isn't too similar.
> > 
> > I missed at least one thing:
> > 
> > Don't #include <linux/config.h>
> > That is done automatically now by Kbuild.  Source files
> > should not do it.  (you could wait to see if there are other comments. :)
> > 
> > ---
> > ~Randy
> 
> Are you sure?  Will it rebuild a file if a config entry is changed that
> is simply mentioned in an #ifdef?
> 
> Is this a recent change?  It wasn't working this way in 2.6.17.1--it
> automatically noticed changes to the config of the file itself, but not
> to config symbols tested using #ifdef.

Actually the Kbuild system auto. includes <linux/autoconf.h> which is
generated from config.h.  2.6.17.* should be the same.
It's been this way since last Oct. (although I can't find that
message that was just posted today [July 5]).

http://lkml.org/lkml/2006/7/5/124

---
~Randy
