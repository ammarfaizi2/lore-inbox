Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933676AbWKQPqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933676AbWKQPqd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933679AbWKQPqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:46:33 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:21127 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S933676AbWKQPqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:46:32 -0500
Date: Fri, 17 Nov 2006 15:46:27 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061117154627.GA1544@srcf.ucam.org>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz> <20061107204409.GA37488@vasa.acc.umu.se> <20061107134439.1d54dc66.kristen.c.accardi@intel.com> <20061117102237.GS14886@vasa.acc.umu.se> <20061117151341.GA1162@srcf.ucam.org> <20061117153717.GU14886@vasa.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117153717.GU14886@vasa.acc.umu.se>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 04:37:17PM +0100, David Weinehall wrote:

> The fact that the dock starts to beep annoyingly. It has a button that
> you should press before undocking, and wait for a green light to light
> up before removing the laptop.  If you remove the computer without
> doing so, the dock starts beeping, and it doesn't stop (AFAIK, haven't
> managed to stand the beeping for more than 30 seconds or so) until you
> replug the laptop.

Ah, hm. Interesting. Maybe it does want OS support, then. Have you tried 
it in the Leading Brand OS?

> My guess is that there is some wait to trigger an undock event from
> software as well, and that it would be nice to send that signal to the
> dock before suspending...

You possibly don't want to do that if there's a mounted bay device in 
the dock.

We really need to determine some sort of policy when it comes to mounted 
devices that will potentially be removed by the user over 
suspend/resume. Do we support this configuration (by not killing the 
mount point), or do we prevent users from shooting themselves in the 
foot?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
