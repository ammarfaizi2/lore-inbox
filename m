Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbTCYBxe>; Mon, 24 Mar 2003 20:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbTCYBxe>; Mon, 24 Mar 2003 20:53:34 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:63640 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261384AbTCYBxc>; Mon, 24 Mar 2003 20:53:32 -0500
Date: Tue, 25 Mar 2003 02:04:19 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH] More i2c driver changes for 2.5.65
Message-ID: <20030325020418.GB8048@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Greg KH <greg@kroah.com>, Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
References: <10482950873871@kroah.com> <10482950921680@kroah.com> <20030325093550.GD1083@zaurus.ucw.cz> <20030325012923.GA10879@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325012923.GA10879@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 05:29:23PM -0800, Greg KH wrote:

 > > > +	.name		= "ADM1021-MAX1617",
 > > Why dash here
 > > > +	.name		= "LM75 sensor",
 > > And space here? Also you should have 
 > > either 2x "sensor" or none at all. 
 > What do you mwan "2x"?

The way I parsed it, either have..
 .name = "ADM1021-MAX1617 sensor",
 .name = "LM75 sensor",

or

 .name = "ADM1021-MAX1617",
 .name = "LM75",

ie, both, or all. Personally the latter looks better to me.
Especially given the 16 char limit.  Aren't these going to
be in a sysfs heirarchy where its obvious they are sensors
anyway ? like i2c/sensors/lm75 ?

		Dave

