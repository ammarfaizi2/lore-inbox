Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132758AbRDQQrX>; Tue, 17 Apr 2001 12:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132759AbRDQQrE>; Tue, 17 Apr 2001 12:47:04 -0400
Received: from jffdns01.or.intel.com ([134.134.248.3]:60880 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S132758AbRDQQq6>; Tue, 17 Apr 2001 12:46:58 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE847@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Let init know user wants to shutdown
Date: Tue, 17 Apr 2001 09:45:07 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@suse.cz]
> > I would think that it would make sense to keep shutdown 
> with all the other
> > power management events. Perhaps it will makes more sense 
> to handle UPS's
> > through the power management code.
> 
> Yes, that would be another acceptable solution. Situation where half
> of power managment (UPS) is done with init and half with acpid is not
> acceptable. [I doubt UPS users will want to switch. Why invent new
> daemon when init is doing perfect job?]

Hi Pavel,

I think init is doing a perfect job WRT UPSs because this is a trivial
application of power management. init wasn't really meant for this.
According to its man page:

"init...it's primary role is to create processes from a script in the file
/etc/inittab...It also controls autonomous processes required by any
particular system"

We are going to need some software that handles button events, as well as
thermal events, battery events, polling the battery, AC adapter status
changes, sleeping the system, and more.

We need WAY more flexibility than init provides. I find the argument that
init is already handling one minor power-related thing an unconvincing
reason why we should cram all power management through it.

Unix philosophy: "do one thing and do it well".

Regards -- Andy

