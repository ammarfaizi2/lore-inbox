Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSLAQl0>; Sun, 1 Dec 2002 11:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSLAQl0>; Sun, 1 Dec 2002 11:41:26 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:12549 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261908AbSLAQl0>;
	Sun, 1 Dec 2002 11:41:26 -0500
Date: Sun, 1 Dec 2002 09:49:23 -0800
From: Greg KH <greg@kroah.com>
To: Crispin Cowan <crispin@wirex.com>
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM fix for stupid "empty" functions
Message-ID: <20021201174922.GB8829@kroah.com>
References: <20021201083056.GJ679@kroah.com> <3DE9C5B2.4070404@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DE9C5B2.4070404@wirex.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 12:17:54AM -0800, Crispin Cowan wrote:
> Greg KH wrote:
> 
> >I'm _really_ tired of all of the "empty" functions that all security
> >modules need to provide.  So here's a brute force patch that lets any
> >security module only set the functions that it wants to override.  If
> >the function is NULL, then the "dummy" function will be used instead.
> >
> Sounds good to me. So you're just creating a default null function, and 
> then stuffing all the stubs with a pointer to that function?

No, it uses the dummy_* function that matches that function type if you
do not specify the function.  Look at the definition of the
set_to_dummy_if_null() macro for how it works.

thanks,

greg k-h
