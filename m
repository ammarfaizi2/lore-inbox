Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSJCWMn>; Thu, 3 Oct 2002 18:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbSJCWMn>; Thu, 3 Oct 2002 18:12:43 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:22541 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261322AbSJCWMm>;
	Thu, 3 Oct 2002 18:12:42 -0400
Date: Thu, 3 Oct 2002 15:15:25 -0700
From: Greg KH <greg@kroah.com>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
Message-ID: <20021003221525.GA2221@kroah.com>
References: <20021003153943.E22418@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021003153943.E22418@openss7.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 03:39:43PM -0600, Brian F. G. Bidulock wrote:
> I see that RH, in their infinite wisdom, have seen fit to remove
> the export of sys_call_table in 8.0 kernels breaking any loadable
> modules that wish to implement non-implemented system calls such
> as LiS's or iBCS implementation of putmsg/getmsg.
> 
> sys_call_table is exported in current 2.4 and 2.5 kernels.

As of 2.5.40bk it is now also not exported, which is a good thing.

> Until now, loadable modules have been able to just overwrite
> the non implemented point in the sys_call_table when they load
> and putting it back when they unload.  There is no mechanism
> for registering system calls.

That's a racy, easily breakable thing to do.  Don't do it.

> What is the kernel.org take on this?

It is a good thing that the sys_call_table is now not exported.

thanks,

greg k-h
