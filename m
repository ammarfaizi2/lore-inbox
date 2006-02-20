Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932682AbWBTWfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbWBTWfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWBTWfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:35:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:52921 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932682AbWBTWfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:35:54 -0500
Date: Mon, 20 Feb 2006 14:27:04 -0800
From: Greg KH <greg@kroah.com>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel@vger.kernel.org, axboe@suse.de, karim@opersys.com
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060220222704.GD28042@kroah.com>
References: <20060219171748.GA13068@linux-sh.org> <20060219175623.GA2674@kroah.com> <20060219185254.GA13391@linux-sh.org> <17401.21427.568297.830492@tut.ibm.com> <20060220130555.GA29405@Krystal> <20060220171531.GA9381@linux-sh.org> <20060220173732.GA7238@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220173732.GA7238@Krystal>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 12:37:32PM -0500, Mathieu Desnoyers wrote:
> 
> debugfs seems to offer really too much flexibility for what LTTng needs. It
> doesn't really have to redefine "new" operations : the poll/ioctl used by LTTng
> could in fact be integrated into RelayFS and simplify the file reading
> operation.

Heh, you don't _have_ to use all of the flexibility in debugfs if you
don't want to do so.  Why not create a simple debugfs wrapper function
(like the ones already present) to create the file in the format that
you wish to have it in?  I'd be glad to accept such a patch.

And yes, I think LTT should be using debugfs, as that is exactly what it
was created for (debugging stuff.)

thanks,

greg k-h
