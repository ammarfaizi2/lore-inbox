Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbUKJDtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbUKJDtx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 22:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUKJDtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 22:49:53 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:23676 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261488AbUKJDtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 22:49:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Date: Tue, 9 Nov 2004 22:49:43 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, Tejun Heo <tj@home-tj.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20041109223729.GB7416@kroah.com> <d120d5000411091536115ac91b@mail.gmail.com> <20041110003323.GA8672@kroah.com>
In-Reply-To: <20041110003323.GA8672@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411092249.44561.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 November 2004 07:33 pm, Greg KH wrote:
> All we have to do is rework that rwsem lock.  It's been staring at us
> since the beginning of the driver core work, and we knew it would have
> to be fixed eventually.  So might as well do it now.
> 
...
> 
> So, off to rework this mess...
> 

Do you have any ideas here? For me it seems that the semaphore has a dual
role - protecting bus's lists and ensuring that probe/remove routines are
serialized across bus...

In the meantime, can I please have bind_mode patch applied? I believe
it is useful regardless of which bind/unbind solution will be adopted
and having them will allow me clean up serio bus implementaion quite a
bit.

Pretty please...

-- 
Dmitry
