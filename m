Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSLASRg>; Sun, 1 Dec 2002 13:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSLASRg>; Sun, 1 Dec 2002 13:17:36 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:25349 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262224AbSLASRg>;
	Sun, 1 Dec 2002 13:17:36 -0500
Date: Sun, 1 Dec 2002 11:25:32 -0800
From: Greg KH <greg@kroah.com>
To: James Morris <jmorris@intercode.com.au>
Cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM fix for stupid "empty" functions
Message-ID: <20021201192532.GA9278@kroah.com>
References: <20021201181227.GC8829@kroah.com> <Mutt.LNX.4.44.0212020441560.19785-100000@blackbird.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0212020441560.19785-100000@blackbird.intercode.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 04:46:43AM +1100, James Morris wrote:
> On Sun, 1 Dec 2002, Greg KH wrote:
> 
> > On Sun, Dec 01, 2002 at 05:59:10PM +0100, Olaf Dietsche wrote:
> > > >  	VERIFY_STRUCT(struct security_operations, ops, err);
> > > 
> > > This shouldn't be necessary anymore.
> > 
> > Good point, I'll remove it.  It was a hack anyway :)
> > 
> 
> I think we still want to make sure that the module author has explicitly
> accounted for all of the hooks, in case new hooks are added.

But with this patch, if the module author hasn't specified a hook, they
get the "dummy" ones.  So the structure should always be full of
pointers, making the VERIFY_STRUCT macro pointless.

thanks,

greg k-h
