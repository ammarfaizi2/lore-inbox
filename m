Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbVINRjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbVINRjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVINRjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:39:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:42976 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030250AbVINRjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:39:48 -0400
Date: Wed, 14 Sep 2005 10:39:18 -0700
From: Greg KH <greg@kroah.com>
To: dtor_core@ameritech.net
Cc: Robert Love <rml@novell.com>, Mr Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] hdaps driver update.
Message-ID: <20050914173918.GB24058@kroah.com>
References: <1126713453.5738.7.camel@molly> <20050914160527.GA22352@kroah.com> <1126714175.5738.21.camel@molly> <20050914161622.GA22875@kroah.com> <d120d5000509141028252d060c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000509141028252d060c@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 12:28:15PM -0500, Dmitry Torokhov wrote:
> On 9/14/05, Greg KH <greg@kroah.com> wrote:
> > 
> > No, if you have that .owner field in your driver, you get a symlink in
> > sysfs that points from your driver to the module that controls it.  You
> > just removed that symlink, which is not what I think you wanted to have
> > happen :(
> > 
> 
> Hmm, i have a concern WRT to that link - it is only present if driver
> is registered from a code compiled as a module. If driver is built-in
> THIS_MODULE is NULL and symlink will not be created. Hovewer
> /sys/modules/<module> is created regardless of whether module is a
> module or built-in. So the behavior is inconsistent and it looks like
> a replacement is needed.

Ok, care to come up with a suggestion of how to fix this?

thanks,

greg k-h
