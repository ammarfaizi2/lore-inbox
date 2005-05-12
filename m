Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVELPnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVELPnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 11:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVELPnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 11:43:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:48867 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262045AbVELPni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 11:43:38 -0400
Date: Thu, 12 May 2005 08:43:35 -0700
From: Greg KH <greg@kroah.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: kobject_register failed for intelfb (-EACCES) (Re: 2.6.12-rc4-mm1)
Message-ID: <20050512154335.GD21765@kroah.com>
References: <20050512033100.017958f6.akpm@osdl.org> <200505121658.02019.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505121658.02019.adobriyan@gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 04:58:01PM +0400, Alexey Dobriyan wrote:
> kobject Intel(R) 830M/845G/852GM/855GM/865G/915G Framebuffer Driver:
> registering. parent: <NULL>, set: drivers
> kobject_register failed for Intel(R) 830M/845G/852GM/855GM/865G/915G

Someone tried to put a "/" in a kobject name, which is not allowed.
Actually the name seems to be set to:
	"Intel(R) 830M/845G/852GM/855GM/865G/915G Framebuffer Driver"
which is a bit verbous if you want to create a directory name :)

thanks,

greg k-h
