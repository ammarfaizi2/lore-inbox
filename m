Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWBSX55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWBSX55 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWBSX54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:57:56 -0500
Received: from digitalimplant.org ([64.62.235.95]:4296 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932464AbWBSX54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:57:56 -0500
Date: Sun, 19 Feb 2006 15:57:43 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@suse.cz>
cc: greg@kroah.com, "" <torvalds@osdl.org>, "" <akpm@osdl.org>,
       "" <linux-pm@osdl.org>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH 2/5] [pm] Add state field to pm_message_t (to
 hold actual state device is in)
In-Reply-To: <20060218155104.GD5658@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.50.0602191554560.8676-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171757360.30811-100000@monsoon.he.net>
 <20060218155104.GD5658@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 18 Feb 2006, Pavel Machek wrote:

> Hi!
>
>
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index 5be87ba..a7324ea 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -140,6 +140,7 @@ struct device;
> >
> >  typedef struct pm_message {
> >  	int event;
> > +	u32 state;
> >  } pm_message_t;
>
> We have had enough problems with u32s before... What about
> char *, and pass real state names?

I certainly agree that is better in an ideal implementation. But, the
intent of the patches was not to fix the infrastructure; it was to fix the
interface to be compatible with previous behavior (while accounting for
changes made in the area that happened in the process of breaking it).

Thanks,


	Pat

