Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272233AbTGYRj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 13:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272230AbTGYRjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 13:39:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:51122 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272234AbTGYRjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 13:39:51 -0400
Date: Fri, 25 Jul 2003 13:19:32 -0400
From: Greg KH <greg@kroah.com>
To: ffrederick@prov-liege.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shm kobject model against 2.6t1
Message-ID: <20030725171932.GA1553@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 11:35:05AM +0200, ffrederick@prov-liege.be wrote:
>            -export shm to sysfs using kobject model
> 	   -unregistering (Greg)

I don't see you setting the kobject release function which is necessary
if you have a sysfs file that users can open.  Try setting that and this
will work better.

thanks,

greg k-h
