Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262635AbTCZXfo>; Wed, 26 Mar 2003 18:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262641AbTCZXfo>; Wed, 26 Mar 2003 18:35:44 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:32518 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262635AbTCZXfn>;
	Wed, 26 Mar 2003 18:35:43 -0500
Date: Wed, 26 Mar 2003 15:46:01 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
Subject: Re: w83781d i2c driver updated for 2.5.66 (without sysfs support)
Message-ID: <20030326234601.GB27436@kroah.com>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <20030326202904.GK24689@kroah.com> <1048721671.7569.46.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048721671.7569.46.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 01:34:32AM +0200, Martin Schlemmer wrote:
> 
> Quick question .... With sysfs, is it not needed to call
> i2c_detach_client ?   I am asking this as it seems from patches
> that you remove all these calls ...

No, that's still required.  I didn't delete that in my lm75.c patch, did
I?

You just don't have to call i2c_deregister_entry, as we don't call
i2c_register_entry anymore.

thanks,

greg k-h
