Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263437AbUKZWZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263437AbUKZWZB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbUKZWKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:10:54 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:43701 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264014AbUKZV6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 16:58:12 -0500
Subject: Re: Suspend 2 merge: 50/51: Device mapper support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125235829.GJ2909@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101300802.5805.398.camel@desktop.cunninghams>
	 <20041125235829.GJ2909@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101427667.27250.175.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 11:07:47 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 10:58, Pavel Machek wrote:
> Hi!
> 
> > This is the device mapper support plugin. Its sole purpose is to ensure
> > that the device mapper allocates enough memory to process all of the I/O
> > we want to throw at it.
> 
> This needs to go through dm people....

Yes. I'll look for contact details.

> > +static struct suspend_proc_data disable_dm_support_proc_data = {
> > +	.filename			= "disable_device_mapper_support",
> > +	.permissions			= PROC_RW,
> > +	.type				= SUSPEND_PROC_DATA_INTEGER,
> > +	.data = {
> > +		.integer = {
> > +			.variable	= &suspend_dm_ops.disabled,
> > +			.minimum	= 0,
> > +			.maximum	= 1,
> > +		}
> > +	}
> > +};
> 
> What is this good for? Debugging switch?

Nod. If built as modules, you can of course just rmmod.

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

