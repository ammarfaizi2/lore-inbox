Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbTADWfd>; Sat, 4 Jan 2003 17:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbTADWfd>; Sat, 4 Jan 2003 17:35:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7953 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261642AbTADWfb>;
	Sat, 4 Jan 2003 17:35:31 -0500
Date: Sat, 4 Jan 2003 22:44:04 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] acpi_os_queue_for_execution()
Message-ID: <20030104224404.C19239@parcelfarce.linux.theplanet.co.uk>
References: <F760B14C9561B941B89469F59BA3A84725A107@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A107@orsmsx401.jf.intel.com>; from andrew.grover@intel.com on Fri, Jan 03, 2003 at 11:00:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 11:00:04AM -0800, Grover, Andrew wrote:
> Are we allowed to block in a timer callback? One of the things
> thermal_check does is call a control method, which in turn can be very
> slow, sleep, etc., so I'd guess that's why the code tries to execute
> things in its own thread.

timers are run in bottom-half context.  no sleeping allowed.  if you're
going to linux.conf.au, you'll want to attend my talk that deals with
exactly this kind of thing ;-)

i'll put the paper up on the web in a couple of weeks, after the
proceedings are published.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
