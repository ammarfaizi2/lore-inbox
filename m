Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWBJMTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWBJMTd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWBJMTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:19:33 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20457 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751177AbWBJMTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:19:32 -0500
Date: Fri, 10 Feb 2006 13:19:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060210121913.GA4974@elf.ucw.cz>
References: <20060208125753.GA25562@srcf.ucam.org> <20060210080643.GA14763@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060210080643.GA14763@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 10-02-06 09:06:43, Stefan Seyfried wrote:
> On Wed, Feb 08, 2006 at 12:57:53PM +0000, Matthew Garrett wrote:
> > The included patch adds support for power management methods to register 
> > callbacks in order to allow drivers to check if the system is on AC or 
> > not. Following patches add support to ACPI and APM. Feedback welcome.
> 
> Ok. Maybe i am not seeing the point. But why do we need this in the kernel?
> Can't we handles this easily in userspace?

Some kernel parts need to now: for example powernow-k8: some
frequencies are not allowed when you are running off battery. [Just
now it is solved by not allowing those frequencies at all unless ACPI
is available; quite an ugly solution.]

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
