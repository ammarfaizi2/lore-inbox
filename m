Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267838AbTAHTWb>; Wed, 8 Jan 2003 14:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267849AbTAHTWb>; Wed, 8 Jan 2003 14:22:31 -0500
Received: from fmr02.intel.com ([192.55.52.25]:19703 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267838AbTAHTWb>; Wed, 8 Jan 2003 14:22:31 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A10E@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Pavel Machek <pavel@ucw.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: RE: [ACPI] RE: kacpidpc needs to die
Date: Wed, 8 Jan 2003 11:24:17 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Grover, Andrew 
> > From: Pavel Machek [mailto:pavel@ucw.cz] 
> > For reasons discussed before [forking from timer is not 
> safe, anyway],
> > kacpidpc needs to die. Andrew, are you going to kill it or 
> should I do
> > it?
> 
> I can kill it...let me just verify with you --
> acpi_os_queue_for_execution has a two block switch statement, just use
> the first block (the case that uses schedule_work) and delete 
> the rest,
> yes?

Oops, and combine acpi_os_schedule_exec and acpi_os_queue_exec, so that
we call dpc->function() from the original thread. Anything else?

-- Andy


