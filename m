Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270062AbUJHROi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270062AbUJHROi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270065AbUJHROi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:14:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:8852 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270062AbUJHROg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:14:36 -0400
Date: Fri, 8 Oct 2004 10:14:14 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linus@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect against buggy drivers
Message-ID: <20041008171414.GA28001@kroah.com>
References: <1097254421.16787.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097254421.16787.27.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 09:53:41AM -0700, Stephen Hemminger wrote:
> +	    strlen(name) >= KOBJ_NAME_LEN || 

There's no need for this check, if we fix the other usage of
cdev->kobj.name in this file to use the proper kobject_name() and
kobject_set_name() functions.

thanks,

greg k-h
