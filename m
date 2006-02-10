Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWBJMVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWBJMVW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWBJMVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:21:22 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21225 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751087AbWBJMVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:21:21 -0500
Date: Fri, 10 Feb 2006 13:21:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060210122104.GB4974@elf.ucw.cz>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org> <20060208222532.GA4824@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208222532.GA4824@titan.lahn.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 08-02-06 23:25:32, Philipp Matthias Hahn wrote:
> Hi!
> 
> On Wed, Feb 08, 2006 at 01:04:22PM +0000, Matthew Garrett wrote:
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> ...
> > +void pm_set_ac_status(int (*ac_status_function)(void))
> > +{
> > +	down(&pm_sem);
> > +	get_ac_status = ac_status_function;
> > +	up(&pm_sem);
> > +}
> 
> Why do you need a semaphore/mutex, when you only do one assignment,
> which is atomic by itself?

It is not.
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
