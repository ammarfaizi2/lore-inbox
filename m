Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbTAOHAa>; Wed, 15 Jan 2003 02:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbTAOHAa>; Wed, 15 Jan 2003 02:00:30 -0500
Received: from fmr01.intel.com ([192.55.52.18]:990 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265787AbTAOHA3>;
	Wed, 15 Jan 2003 02:00:29 -0500
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E01087ADB@orsmsx402.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>,
       Louis Zhuang <louis.zhuang@linux.co.intel.com>
Cc: jgarzik@redhat.com, "Feldman, Scott" <scott.feldman@intel.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: RE: [BUG FIX] e100 initialization issue on STL2 motherboard
Date: Tue, 14 Jan 2003 23:09:17 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Tue, Jan 14, 2003 at 01:51:55PM +0800, Louis Zhuang wrote:
> > 	The patch will increase waiting time in SCB 
> initialization. It will 
> > resolve the issue on STL2 motherboard. Pls apply.
> 
> Sorry, not applied.
> 
> I was kinda hoping Scott would fix that up.  It is a verified 
> problem (SMBus timeout, IIRC?), and this does indeed fix the problem.

Agreed, don't apply this patch - it's not the right fix.

The solution requires a specific TCO workaround on 82559 to
schedule_timeout after hard reset of the controller, and then follow
that with a wait for TCO traffic to quiesce.  Patch forthcoming...

-scott
