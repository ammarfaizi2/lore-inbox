Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWBPWoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWBPWoD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWBPWoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:44:03 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:58288
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932075AbWBPWoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:44:01 -0500
Date: Thu, 16 Feb 2006 14:43:46 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: more documentation in source files
Message-ID: <20060216224346.GA17190@kroah.com>
References: <20060216214033.GA5517@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216214033.GA5517@admingilde.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 10:40:34PM +0100, Martin Waitz wrote:
> hoi :)
> 
> I'd like to move some of the documentation which sleeps in Documentation/
> into the .c files that contain the documented code in the hope that
> somebody who changes the code also changes the documentation in one go.
> 
> We already have a system to generate documentation from the .c files,
> so I made a little experiment and tried to use kernel-doc to build
> the complete documentation after all text from the template files got
> moved to the source files.
> I haven't really succeeded in generating valid docbook output from
> the source files alone. So I looked at other tools to do this job.
> 
> Doxygen looks fairly promising and is even already used by some
> kernel files.
> You can get a first impression of Doxygen output here:
> http://tali.admingilde.org/linux-doxygen/html/group__drivermodel.html
> For these pages I stuffed some files from Documentation/driver-model/
> into drivers/base/*.c and changed some kernel-doc comments to Doxygen
> comments.
> 
> However there are several drawbacks when using Doxygen:
>  * it doesn't generate DocBook
>  * the source markup does not look as nice as kernel-doc:
> 	/**
> 	 * foo - short description
> 	 * @param1: parameter description
> 	 * long description
> 	 */
> 	gets:
> 	/**
> 	 * short description.
> 	 * \param param1 parameter description.
> 	 * long description
> 	 */
>    but on the other side it's much more powerful, too.
>  * we need some transition strategy

What's wrong with just extending kerneldoc in the ways that you feel it
would be more powerful?

What specifically do you feel is lacking in kerneldoc that doxygen
provides?

thanks,

greg k-h
