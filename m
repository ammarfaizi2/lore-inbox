Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTJ1SM1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 13:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbTJ1SM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 13:12:27 -0500
Received: from rav-az.mvista.com ([65.200.49.157]:30276 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261311AbTJ1SMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 13:12:14 -0500
Subject: Re: ANNOUNCE: User-space System Device Enumation (uSDE)
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Mark Bellon <mbellon@mvista.com>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031028110034.GG30725@marowsky-bree.de>
References: <3F9D82F0.4000307@mvista.com>
	 <20031027210054.GR24286@marowsky-bree.de> <3F9D8AAA.7010308@mvista.com>
	 <20031028110034.GG30725@marowsky-bree.de>
Content-Type: text/plain; charset=UTF-8
Organization: MontaVista Software, Inc.
Message-Id: <1067364727.4612.359.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 28 Oct 2003 11:12:07 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-28 at 04:00, Lars Marowsky-Bree wrote:
> On 2003-10-27T14:14:18,
>    Mark Bellon <mbellon@mvista.com> said:
> 
> > The uSDE and udev are simlar in some respects. The uSDE allows for 
> > complete control of the policy handling a device - not just its naming. 
> 
> Well, so could udev in theory, and I had this plan to enhance it to do
> so for the specific case of multipathing one day in the not too distant
> future (ie, before q1/04).
> 
> In as far as I can see, udev and uSDE really do not have too different
> goals. Competition is good, but only if they explore distinct approaches
> ;-)
> 
There are several distinct approaches which have been enumerated in
other mails.

Since this point has not been addressed, I'd like to focus on the major
difference in philosophy.

SDE places all policy in the hands of the policy developer in a seperate
policy program.  udev places the policies in the main processing loop of
the system, effectively implementing whatever policy is desired by the
udev maintainers.

Without seperating policies from the core executive of device naming
system, the core of udev suffers from the same issues as placing policy
in the kernel suffers.   Lack of maintainability, lack of user-defined
functionality, bloat, etc.

> > >How does this integrate with DM, md, EVMS, LVM...?
> > As devices appear in sysfs the uSDE reacts to them via their hotplug 
> > events. The policy for each device handles any device issues including 
> > dealing with any device nodes.  It is possible to track and maintain 
> > multiported devices and automatically provide multipath devices nodes 
> > for instance.
> 
> Yes, I know that, I was asking whether you had done any discussion with
> the EVMS2 folks for example to have a policy plugin to interact with
> EVMS2 accordingly and do the magic.
> 
> 
No but this is definately a good idea.
Thanks!
-steve
> 
> Sincerely,
>     Lars Marowsky-Brée <lmb@suse.de>

