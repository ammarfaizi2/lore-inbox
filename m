Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTEIQdg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbTEIQdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:33:35 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:63383 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263310AbTEIQde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:33:34 -0400
Date: Fri, 9 May 2003 01:08:08 -0700
From: Greg KH <greg@kroah.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030509080808.GA6254@kroah.com>
References: <200305071507_MC3-1-37CF-FE32@compuserve.com> <1052387912.4849.43.camel@pc-16.office.scali.no> <20030508095943.B22255@devserv.devel.redhat.com> <1052398474.4849.57.camel@pc-16.office.scali.no> <20030508135839.A6698@infradead.org> <3EBAAB9D.5000508@shemesh.biz> <20030508201509.A19496@infradead.org> <20030509074208.GA14991@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509074208.GA14991@actcom.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 10:42:08AM +0300, Muli Ben-Yehuda wrote:
> 
> For example, a rogue process is calling settimeofday() on your router
> once a month(!). How are you going to find it? There's no LSM hook for
> settimeofday()

Yes there is.  Check the capable hook for CAP_SYS_TIME.  LSM modules can
get that info quite easily.

thanks,

greg k-h
