Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261817AbSIXVHk>; Tue, 24 Sep 2002 17:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261818AbSIXVHj>; Tue, 24 Sep 2002 17:07:39 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:64964 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261817AbSIXVHh>;
	Tue, 24 Sep 2002 17:07:37 -0400
Message-ID: <3D90D503.8F4CDEB6@us.ibm.com>
Date: Tue, 24 Sep 2002 14:11:31 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [evlog-dev] Re: alternate event logging proposal
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C183.5020806@pobox.com> <3D90C3B0.8090507@nortelnetworks.com> <3D90C670.90508@pobox.com> <3D90CACE.595EA229@us.ibm.com> <3D90CC8F.4080706@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Larry Kessler wrote:
> > Jeff Garzik wrote:
> >>To address your more general point, a general way to notify interested,
> >>credentialed (is that a word?) 3rd party processes of device events
> >>would indeed be useful.  Since such events are essential out-of-band
> >>info, netlink might indeed be applicable.
> >
> >
> > Event Logging has both a command and an API for apps in user-space to
> > register for specific events (kernel or userspace).   The user must have
> > read access to the log file and the proper credentials in the allow/deny
> > file scheme (that's modeled after crontab).
> 
> Ok.  And?  It sounds like event logging could possibly use netlink as
> the event delivery mechanism.

Event logging uses real-time signaling to notify a process that's registered
for notification that an event matching the criteria defined during 
registration has been written to the event log.  When notified, the process
can read the entire event from the event log and then do whatever.
.
It's intended to satisfys the requirement for a "general way to notify...processes".
To read more, go to...
http://evlog.sourceforge.net/posix_evlog.html#_Toc525541312
