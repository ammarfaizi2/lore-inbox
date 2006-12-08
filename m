Return-Path: <linux-kernel-owner+w=401wt.eu-S1947223AbWLHVNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947223AbWLHVNK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947245AbWLHVNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:13:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:33980 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947223AbWLHVNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:13:08 -0500
Date: Fri, 8 Dec 2006 13:12:53 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jiri Kosina <jkosina@suse.cz>,
       Marcel Holtmann <marcel@holtmann.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] HID patches for 2.6.19
Message-ID: <20061208211253.GA8694@suse.de>
References: <20061208185419.GA6912@kroah.com> <Pine.LNX.4.64.0612081126420.3516@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612081126420.3516@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 11:28:57AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 8 Dec 2006, Greg KH wrote:
> >
> > Here are some patches that move the HID code to a new directory allowing
> > it to be used by other kernel subsystems easier.
> 
> I pulled. However, I think the Kconfig changes are HORRIBLE.
> 
> I don't understand why people don't use "select" more. Why should Kconfig 
> ask for "Generic HID support?" That question _never_ makes sense to a 
> user. And if you answer "n", you'll not get USB_HID.
> 
> This is not user-friendly. If you need HID support, just select it. Don't 
> ask people questions that make no sense. If the generic HID code is needed 
> for some driver, you just select it. If it's not needed, you don't. It's 
> that easy.

I think some people feel we are using "select" too much at times, so
that is why it was done that way.

But in this case, yes, I do think it would make it easier for the user
if it was changed.  Jiri, care to make up a new patch that does this?

thanks,

greg k-h
