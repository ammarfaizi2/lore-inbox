Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932627AbWCPSAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbWCPSAZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbWCPSAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:00:24 -0500
Received: from [84.204.75.166] ([84.204.75.166]:39128 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S932627AbWCPSAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:00:24 -0500
Subject: Re: [Bug? Report] kref problem
From: "Artem B. Bityutskiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060316172039.GB5624@kroah.com>
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru>
	 <20060316165323.GA10197@kroah.com>
	 <1142528877.3920.64.camel@sauron.oktetlabs.ru>
	 <1142529004.3920.66.camel@sauron.oktetlabs.ru>
	 <20060316172039.GB5624@kroah.com>
Content-Type: text/plain
Organization: MTD
Date: Thu, 16 Mar 2006 21:00:19 +0300
Message-Id: <1142532019.3920.79.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 09:20 -0800, Greg KH wrote:
> Again, why are you trying to call the sysfs raw functions?  You are not
> registering the kobject with the kobject core, so bad things are
> happening.  Why not call kobject_register() or kobject_add(), like it is
> documented to do so?

Well, we were discussing this with you some time ago, and you pointed me
to these raw functions. My stuff just does not fit device/driver/bu
modes and you said I have to create whatever sysfs hierarchy I want with
the raw functions.

kobject_register()/kobject_del() instead of
sysfs_create_dir()/sysfs_remove_dir() solved my problem, thanks. Just to
refine this, I'm still going to use
sysfs_create_file()/sysfs_remove_file() to create whatever attributes I
want, is this right?

I've just noticed similarity in naming: sysfs_remove_file() creates a
file, so the symmetrical sysfs_create_dir() creates a directory. So just
started using it. From the names it was not obvious that I could
not. :-)

Thanks.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

