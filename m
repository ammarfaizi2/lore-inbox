Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267987AbUI1Rsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267987AbUI1Rsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 13:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267998AbUI1Rsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 13:48:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9621 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267987AbUI1Rsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 13:48:32 -0400
Date: Tue, 28 Sep 2004 12:57:53 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       germano.barreiro@cyclades.com
Subject: Re: [PATCH] cyclades.c sysfs statistics support
Message-ID: <20040928155753.GC12494@logos.cnet>
References: <20040928120421.GB11779@logos.cnet> <20040928141242.GA27728@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928141242.GA27728@kroah.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 07:12:43AM -0700, Greg KH wrote:
> On Tue, Sep 28, 2004 at 09:04:21AM -0300, Marcelo Tosatti wrote:
> > +    device_create_file(&(cy_card[info->card].pdev->dev), &_cydas[line]);            
> 
> Why the array of attributes?  As you only have one (which is wrong...)
> you only need one attribute structure.

Because each of them has a different name. I talked to him 
and he will probably stick the attribute inside each 
device structure.

> > +  show_sys_data - shows the data exported to sysfs/device, mostly the signals status involved in the
> > +  serial communication such as CTS,RTS,DTS,etc
> 
> NO!  sysfs is 1 value per file.  Not a whole bunch of values per one
> file.  Please change this to create a whole bunch of little files, not
> one big one.

Germano will do so.

We really appreciate your comments! Thanks.
