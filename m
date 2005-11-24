Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVKXOew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVKXOew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVKXOew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:34:52 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:5348 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751170AbVKXOev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:34:51 -0500
Date: Thu, 24 Nov 2005 15:34:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Greg KH <greg@kroah.com>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [OOPS] sysfs_hash_and_remove (was Re: What protection ....)
Message-ID: <20051124143401.GB1060@elte.hu>
References: <1132695202.13395.15.camel@localhost.localdomain> <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com> <20051123081845.GA32021@elte.hu> <20051123125212.GD22714@in.ibm.com> <20051124122614.GA16465@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124122614.GA16465@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Maneesh Soni <maneesh@in.ibm.com> wrote:

> So, IMO, it is necessary to explicitly remove links before 
> unregistering the kobject in case of bidirectional cross symlinks.
> 
> The patch from James, is working, because it is not creating the cross 
> symlink itself.

so, what is your suggestion, what should be done to fix the problem? The 
patch below:

> > +		/*
> >  		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
> >  				  class_name);
> > +		*/

> > +		/*
> >  		sysfs_remove_link(&class_dev->dev->kobj, class_name);
> > +		*/

isnt fit for upstream inclusion :-)

	Ingo
