Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbUJ0WUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbUJ0WUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbUJ0WSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:18:34 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:14976 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262759AbUJ0VVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:21:21 -0400
Date: Wed, 27 Oct 2004 23:21:07 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Greg KH <greg@kroah.com>, Norbert Preining <preining@logic.at>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-mm1, class_simple_* and GPL addition
Message-ID: <20041027212107.GA22957@vana.vc.cvut.cz>
References: <20041027135052.GE32199@gamma.logic.tuwien.ac.at> <20041027153715.GB13991@kroah.com> <20041027191728.GA6897@vana.vc.cvut.cz> <1098906941.6990.30.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098906941.6990.30.camel@laptop.fenrus.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 09:55:41PM +0200, Arjan van de Ven wrote:
> On Wed, 2004-10-27 at 21:17 +0200, Petr Vandrovec wrote:
> > VMware's vmnet is broken by this too.  VMware was asked by RedHat to 
> > add udev compatibility to the code, and now you are saying that both
> 
> who in Red Hat (notice the space) asked you this? I'm not aware of any
> official request to vmware to do this...
 
I assumed that email I received from Warren Togami was official notice that
RHEL4 is going to be udev based and that as vmnet does not currently create
its device nodes in /dev, something should be done about it.

As this request was quite popular, and doing it properly through sysfs 
instead of doing several mknods when initscripts run, I filled internal
bug report that RHEL4 will use udev and vmnet should be compatible with
it.  And then I implemented some minimal sysfs support.

Week after that I saw first email from Greg changing sysfs_driver_* & co.
to GPL only.  I did not worry as this set did not comtain class_simple,
and so I assumed that I'm doing nothing wrong.  But today I noticed
that even class_simple is GPL only in -mm.

It was not lot of work, I'd say under 1 hour, but it just does not seem
correct to me, changing symbols visibility after people start using them.

OK, next beta will do several mknods in /etc/init.d/vmware script.
Not technically nice, but working.
					Petr Vandrovec

