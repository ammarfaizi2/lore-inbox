Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932701AbWBXGF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbWBXGF0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 01:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWBXGF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 01:05:26 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:11915
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932687AbWBXGFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 01:05:25 -0500
Date: Thu, 23 Feb 2006 22:05:05 -0800
From: Greg KH <greg@kroah.com>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org, hjlipp@web.de
Subject: Re: [PATCH] reduce syslog clutter
Message-ID: <20060224060505.GA19111@kroah.com>
References: <43FE40CD.3060803@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FE40CD.3060803@imap.cc>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 12:10:05AM +0100, Tilman Schmidt wrote:
> The current versions of the err() / info() / warn() syslog macros
> insert __FILE__ at the beginning of the message, which expands to
> the complete path name of the source file within the kernel tree.

Note, this is the usb usage, you might want to post this on the
linux-usb-devel mailing list :)

> With the following patch, when used in a module, they'll insert the
> module name instead, which is significantly shorter and also tends to
> be more useful to users trying to make sense of a particular message.
> 
> The patch also adds macros for the KERN_NOTICE severity level which
> was so far uncatered for.

Does anyone want to use it?

I suggest splitting this up into two different patches.

thanks,

greg k-h
