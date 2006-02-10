Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWBJNyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWBJNyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWBJNyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:54:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64967 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932069AbWBJNyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:54:38 -0500
Date: Fri, 10 Feb 2006 14:54:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: Gabor Gombas <gombasg@sztaki.hu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Greg KH <greg@kroah.com>,
       linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, seife@suse.de
Subject: Re: [linux-pm] Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060210135415.GC5109@elf.ucw.cz>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org> <20060208165803.GA15239@kroah.com> <20060208170857.GA29818@srcf.ucam.org> <20060209085344.GF16052@boogie.lpds.sztaki.hu> <20060210122131.GC4974@elf.ucw.cz> <20060210131337.GD11740@boogie.lpds.sztaki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060210131337.GD11740@boogie.lpds.sztaki.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 10-02-06 14:13:38, Gabor Gombas wrote:
> On Fri, Feb 10, 2006 at 01:21:31PM +0100, Pavel Machek wrote:
> 
> > Still "set current brightness" operation makes a lot of sense.
> 
> Yes, but userspace already knows if you are on AC power or not,
> therefore it can decide what "current" means. If this is the only reason
> then adding a new kernel infrastructure is overkill.

It is not.

powernow-k8 needs to know if ac is plugged, else it can overload
battery.

backlight code needs it for get current brightness.

on Zauruses, battery charging is done in kernel (not in
hardware). Battery charging obviously needs to know if ac is
connected.

on Zauruses, IIRC backlight control code needs to know ac/dc, because
voltage differs on some internal buses and backlight power needs to be
programmed in different way.

> Also, doing things differently when on AC power smells like a policy
> decision, and AFAIK policy handling is not wanted in the kernel.

It is not policy decision, it is protect-hardware-from-damage on
embedded platorms/pn-k8.

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
