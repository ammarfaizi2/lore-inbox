Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUD1Djk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUD1Djk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 23:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUD1Djk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 23:39:40 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:32721
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S264627AbUD1Dji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 23:39:38 -0400
Subject: Re: [BK PATCH] add SMBIOS tables to sysfs
From: Michael Brown <Michael_E_Brown@Dell.com>
Reply-To: Michael_E_Brown@Dell.com
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040428033020.GA14078@kroah.com>
References: <1083119269.1203.2821.camel@debian>
	 <20040428033020.GA14078@kroah.com>
Content-Type: text/plain
Organization: Dell Inc
Message-Id: <1083123515.1203.2826.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Apr 2004 22:38:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 22:30, Greg KH wrote:
> Nice idea and patch.  A few minor comments:

Thank you.

> 
> > /sys/firmware/smbios/smbios/table_entry_point
> > /sys/firmware/smbios/smbios/table
> 
> Why repeat the "smbios" directory?  Is this a limitation in the sysfs
> interface right now?  Or are you going to put more files in the main
> smbios directory some day?

>From what I could tell (please correct me if I am wrong), you can add
only subsystems to the firmware directory. The first "smbios" is for the
subsystem. Then, you can only add devices to the subsystem. The second
"smbios" is for the device.

I really would like to get rid of one myself, but it was not obvious to
me how to do this. No, I do not plan on adding new objects in there.

> 
> > +	snprintf(sdev->kobj.name, 7, "smbios" );
> 
> Try using kobject_set_name() instead, it will do the proper thing if the
> string is bigger than the base kobj.name field.

Ok, thanks.
Thanks,
Michael

