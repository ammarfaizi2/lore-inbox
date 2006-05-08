Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWEHRQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWEHRQP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWEHRQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:16:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:43909 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932476AbWEHRQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:16:14 -0400
X-IronPort-AV: i="4.05,102,1146466800"; 
   d="scan'208"; a="33202263:sNHT20653074757"
Subject: Re: [patch] add new uevent
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, arjan@linux.intel.com, greg@kroah.com
In-Reply-To: <20060505222234.GA7238@mipter.zuzino.mipt.ru>
References: <1146867216.21633.6.camel@whizzy>
	 <20060505222234.GA7238@mipter.zuzino.mipt.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 08 May 2006 10:24:49 -0700
Message-Id: <1147109089.3094.1.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 08 May 2006 17:14:36.0182 (UTC) FILETIME=[E1A92B60:01C672C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-06 at 02:22 +0400, Alexey Dobriyan wrote:
> On Fri, May 05, 2006 at 03:13:36PM -0700, Kristen Accardi wrote:
> > Add dock uevents so that userspace can be notified of dock and undock
> > events.
> 
> > --- 2.6-git-kca2.orig/include/linux/kobject.h
> > +++ 2.6-git-kca2/include/linux/kobject.h
> > @@ -46,6 +46,8 @@ enum kobject_action {
> >  	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices (broken) */
> >  	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* device offline */
> >  	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* device online */
> > +	KOBJ_UNDOCK	= (__force kobject_action_t) 0x08, 	/* undocking */
> > +	KOBJ_DOCK	= (__force kobject_action_t) 0x09,	/* dock */
> >  };
> >  
> >  struct kobject {
> > --- 2.6-git-kca2.orig/lib/kobject_uevent.c
> > +++ 2.6-git-kca2/lib/kobject_uevent.c
> > @@ -48,6 +48,10 @@ static char *action_to_string(enum kobje
> >  		return "offline";
> >  	case KOBJ_ONLINE:
> >  		return "online";
> > +	case KOBJ_DOCK:
> > +		return "dock";
> > +	case KOBJ_UNDOCK:
> > +		return "undock";
> >  	default:
> >  		return NULL;
> >  	}
> 
> Where exactly are you going to generate them?

Hi Alexey,
These events will be generated from the dock driver.  The patch for this
will be submitted in the next day or 2 (assuming everyone is ok with
adding these events).

Kristen
