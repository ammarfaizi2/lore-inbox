Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266010AbUGIWXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266010AbUGIWXh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 18:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUGIWXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 18:23:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:33958 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266006AbUGIWXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 18:23:35 -0400
Date: Fri, 9 Jul 2004 15:21:54 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesse Stockall <stockall@magma.ca>, s.rivoir@gts.it,
       linux-kernel@vger.kernel.org, stern@rowland.harvard.edu
Subject: Re: 2.6.7-mm7
Message-ID: <20040709222154.GC6284@kroah.com>
References: <20040708235025.5f8436b7.akpm@osdl.org> <40EE5418.2040000@gts.it> <20040709024112.7ef44d1d.akpm@osdl.org> <40EE732C.5020404@gts.it> <1089373506.8067.7.camel@homer.blizzard.org> <20040709115411.23d96699.akpm@osdl.org> <1089402736.8067.12.camel@homer.blizzard.org> <20040709130045.211b6d50.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709130045.211b6d50.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 01:00:45PM -0700, Andrew Morton wrote:
> Jesse Stockall <stockall@magma.ca> wrote:
> >
> > On Fri, 2004-07-09 at 14:54, Andrew Morton wrote:
> >                        down_write_trylock(&usb_all_devices_rwsem));
> >  > 
> >  > That's a bit unusual.  Could you (or Alan) please explain the reason for
> >  > this a little more?
> > 
> >  I believe you want this thread
> > 
> >  http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108923404032264&w=2
> 
> Oh, OK.  Recursively taking an rwsem for reading is certainly deadlocky. 
> The main reason for not supporting this is that heavy down_read() traffic
> can trivially livelock down_write() waiters.  Alan's patch will introduce
> that shortcoming.
> 
> Really, it would be better to get the locking sorted out.

I agree, and we will before submitting the code to Linus.

thanks,

greg k-h
