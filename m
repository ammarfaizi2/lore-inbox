Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbUKQHAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbUKQHAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 02:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbUKQHAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 02:00:40 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:48031 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262214AbUKQHAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 02:00:34 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Date: Wed, 17 Nov 2004 02:00:32 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@home-tj.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Adam Belay <ambx1@neo.rr.com>
References: <20041109223729.GB7416@kroah.com> <d120d50004111612437ebe76d9@mail.gmail.com> <20041116230828.GB16690@kroah.com>
In-Reply-To: <20041116230828.GB16690@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411170200.32860.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 November 2004 06:08 pm, Greg KH wrote:
> On Tue, Nov 16, 2004 at 03:43:21PM -0500, Dmitry Torokhov wrote:
> > On Mon, 15 Nov 2004 21:54:40 -0800, Greg KH <greg@kroah.com> wrote:
> > > On Tue, Nov 09, 2004 at 10:49:43PM -0500, Dmitry Torokhov wrote:
> > > > In the meantime, can I please have bind_mode patch applied? I believe
> > > > it is useful regardless of which bind/unbind solution will be adopted
> > > > and having them will allow me clean up serio bus implementaion quite a
> > > > bit.
> > > >
> > > > Pretty please...
> > > 
> > > Care to resend it?  I can't find it in my archives.
> > > 
> > 
> > Here it is, against 2.6.10-rc2. Apologies for sending it as an attachment
> > but this interface will not let me put it inline without mangling.
> 
> No, for now, if you want to do this, do it in the serio code only, let's
> clean up the locking first before we do this in the core.
> 

*confused* This patch is completely independent from any locking issues in
driver core... It is just 2 flags in device and driver structures that are
checked in device_attach and driver_attach.

-- 
Dmitry
