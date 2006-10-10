Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbWJJMKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWJJMKt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWJJMKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:10:49 -0400
Received: from ns.suse.de ([195.135.220.2]:21148 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965135AbWJJMKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:10:48 -0400
Date: Tue, 10 Oct 2006 14:10:45 +0200
From: Stefan Seyfried <seife@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Jiri Kosina <jikos@jikos.cz>,
       linux-acpi@intel.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] preserve correct battery state through suspend/resume cycles
Message-ID: <20061010121045.GQ19765@suse.de>
References: <Pine.LNX.4.64.0609280446230.22576@twin.jikos.cz> <20060930114817.GA26217@suse.de> <20061008184230.GC4033@ucw.cz> <200610100052.10008.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200610100052.10008.rjw@sisk.pl>
X-Operating-System: SUSE Linux Enterprise Desktop 10 (i586), Kernel 2.6.18-9-default
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 12:52:09AM +0200, Rafael J. Wysocki wrote:
> On Sunday, 8 October 2006 20:42, Pavel Machek wrote:
 
> > > echo "platform" > /sys/power/disk
> > > echo "disk" > /sys/power/state
> > 
> > Maybe we should change the default in 2.6.20 or so?
> 
> Well, I think swsusp should work with "shutdown" just as well.  If it doesn't,
> that means there are some bugs in the ACPI code which should be fixed.
> By using "platform" as the default method we'll be hiding those bugs IMHO.

I'm not really intimately familiar with the ACPI spec, but IIRC those AML
methods executed by pm_ops->prepare and pm_ops->finish are mandatory for
suspending ACPI enabled machines. So using "platform" as a default seems
reasonable (assuming that on non-ACPI machines, pm_ops->{prepare,finish} will
be a noop anyway)
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
