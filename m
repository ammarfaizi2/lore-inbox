Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262074AbTCZUcm>; Wed, 26 Mar 2003 15:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbTCZUcm>; Wed, 26 Mar 2003 15:32:42 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:60422 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262074AbTCZUcg>; Wed, 26 Mar 2003 15:32:36 -0500
Date: Wed, 26 Mar 2003 20:43:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Jan Dittmer <j.dittmer@portrix.net>, azarah@gentoo.org,
       KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@stimpy.netroedge.com
Subject: Re: w83781d i2c driver updated for 2.5.66 (without sysfs support)
Message-ID: <20030326204343.A22053@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Jan Dittmer <j.dittmer@portrix.net>,
	azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@brodo.de>, sensors@stimpy.netroedge.com
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030326202622.GJ24689@kroah.com>; from greg@kroah.com on Wed, Mar 26, 2003 at 12:26:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 12:26:23PM -0800, Greg KH wrote:
> We should really split these multivalue files up into individual files,
> as sysfs is for single value files.  Makes parsing easier too.
> 
> Here's a patch for the lm75.c driver that does this.  As we are going to
> need a "generic" read and write for the "real" values that the i2c
> drivers use, I added these files to the i2c-proc.c file.

i2c-proc.c is the wrong place.  Please add a i2c-sensor.c file with
helper code for hardware sensors driver (i2c_detect should move over to
there from i2c-proc.c aswell)

