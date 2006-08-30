Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbWH3Uu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWH3Uu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 16:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWH3Uu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 16:50:59 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:50119 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751526AbWH3Uu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 16:50:59 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH -mm] PM: Add pm_trace switch
Date: Wed, 30 Aug 2006 22:54:28 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <200608291309.57404.rjw@sisk.pl> <200608302222.36535.rjw@sisk.pl> <20060830203310.GB11531@kroah.com>
In-Reply-To: <20060830203310.GB11531@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608302254.28881.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 22:33, Greg KH wrote:
> On Wed, Aug 30, 2006 at 10:22:36PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday 30 August 2006 19:22, Greg KH wrote:
> > > On Wed, Aug 30, 2006 at 12:02:59PM +0200, Rafael J. Wysocki wrote:
> > > > On Tuesday 29 August 2006 22:46, Andrew Morton wrote:
> > > > > On Tue, 29 Aug 2006 13:09:57 +0200
> > > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > > 
> > > > > > +int pm_trace_enabled;
> > > > > > +
> > > > > > +static ssize_t pm_trace_show(struct subsystem * subsys, char * buf)
> > > > > > +{
> > > > > > +	return sprintf(buf, "%d\n", pm_trace_enabled);
> > > > > > +}
> > > > > > +
> > > > > > +static ssize_t
> > > > > > +pm_trace_store(struct subsystem * subsys, const char * buf, size_t n)
> > > > > > +{
> > > > > > +	int val;
> > > > > > +
> > > > > > +	if (sscanf(buf, "%d", &val) == 1) {
> > > > > > +		pm_trace_enabled = !!val;
> > > > > > +		return n;
> > > > > > +	}
> > > > > > +	return -EINVAL;
> > > > > > +}
> > > > > > +
> > > > > > +power_attr(pm_trace);
> > > > > 
> > > > > <grumbles about documentation>
> > > > 
> > > > Well, this is the most difficult part. ;-)
> > > > 
> > > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > > ---
> > > >  Documentation/power/interface.txt |   15 +++++++++++++++
> > > 
> > > Please update Documentation/ABI/ too.
> > 
> > I could, but there's nothing related to /sys/power/ in Documentation/ABI/
> > right now.
> > 
> > Do you mean I should create a file for /sys/power/ in there?  If so, what
> > should I put in there?  I guess pretty much the same as in
> > Documentation/power/interface.txt ...
> 
> Exactly :)

Okay, but I think that should be done in a separate patch.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
