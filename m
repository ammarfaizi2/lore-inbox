Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264544AbTFQCB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 22:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbTFQCAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 22:00:08 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:29931 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264535AbTFQB7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 21:59:15 -0400
Subject: Re: patch for common networking error messages
To: "David S. Miller" <davem@redhat.com>
Cc: Daniel Stekloff <stekloff@us.ibm.com>, janiceg@us.ibm.com,
       jgarzik@pobox.com, Larry Kessler <lkessler@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFCA1A4F38.D782F1D3-ON85256D48.000A5CED@us.ibm.com>
From: Janice Girouard <girouard@us.ibm.com>
Date: Mon, 16 Jun 2003 21:12:50 -0500
X-MIMETrack: Serialize by Router on D01ML063/01/M/IBM(Release 6.0.1 w/SPRs JHEG5JQ5CD, THTO5KLVS6, JHEG5HMLFK, JCHN5K5PG9|March
 27, 2003) at 06/16/2003 22:12:56
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





  From: Janice Girouard <girouard@us.ibm.com>
   Date: Mon, 16 Jun 2003 19:44:22 -0500

   It sounds like you are proposing a new family for the netlink
   subsystem.

   From: "David S. Miller" <davem@redhat.com>

   Date:06/16/2003 08:19 PM


   Exactly, you have to create this.



Okay.  That solves the issue of events generated in a plethora of formats
for the same event.  Any suggestions on what should be included in this new
family?  I can present a patch to suggest a starting point. However, it
would be great to hear from everyone that has any initial thoughts.



One question that comes to mind, since there is some overlap with netdev
notifier events, should we include those events in the new family?  I can
envision a couple of approaches:



1) keep the two interfaces (netdev notifier and netlink), with separate end
users in mind and duplicate the events to each interface.  Possibly
thinking about migrating to just one interface over time.  Applications
would then just receive one set of events.



2) keep the two interfaces, with no duplication of messages, clarifying the
uses for the two interfaces.  An application would then register, and
obtain events from the two separate mechanisms.

p.s. thanks for all the input so far.





