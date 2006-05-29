Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWE2AMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWE2AMG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 20:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWE2AMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 20:12:06 -0400
Received: from proof.pobox.com ([207.106.133.28]:43139 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1751070AbWE2AMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 20:12:05 -0400
Date: Sun, 28 May 2006 17:12:00 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: Bisects that are neither good nor bad
Message-Id: <20060528171200.629a57df.dickson@permanentmail.com>
In-Reply-To: <20060528150208.3a606c1c.dickson@permanentmail.com>
References: <20060528140238.2c25a805.dickson@permanentmail.com>
	<20060528140854.34ddec2a.paul@permanentmail.com>
	<200605282324.13431.rjw@sisk.pl>
	<20060528150208.3a606c1c.dickson@permanentmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2006 15:02:08 -0700, Paul Dickson wrote:

> On Sun, 28 May 2006 23:24:12 +0200, Rafael J. Wysocki wrote:
> 
> > On Sunday 28 May 2006 23:08, Paul Dickson wrote:
> > > On Sun, 28 May 2006 14:02:38 -0700, Paul Dickson wrote:
> > > 
> > > > Building and testing a good kernel takes me about 70 minutes.  If I make
> > > > mistakes it can easily take two times (or more!) longer.
> > > >
> > > > I'm currently tracking my work at:
> > > >     https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=185108
> > > >
> > > > I'm currently building my fifth bisect.
> > 
> > Could you please also try if the problems persist if you boot with
> > init=/bin/bash?
> 
> I'll try it after I send this message.  I'm guessing you're refering to
> my third bisect.  I still have that and will use it.

The switchroot in the initrd can't find the ext3 root fs.  So no root
found and bash couldn't be found.  This is the third bisect.  All of this
is because of a compiler warning in ext3 and reiserfs.  If I recall
correctly, something like "generic_slice_[...](?) uninitialized".


> I may try sshing into my notebook when I finish these current bisect
> tests to see if it's still the HD being made RO.  This is assuming ssh
> will keep the connection through a suspend.

While ssh retains a connection on a good kernel.  It gets no response
from a bad kernel.

	-Paul

