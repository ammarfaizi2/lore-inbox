Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVC2Dh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVC2Dh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 22:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVC2DhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 22:37:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:39051 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262172AbVC2Dg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 22:36:59 -0500
Date: Mon, 28 Mar 2005 19:33:50 -0800
From: Greg KH <greg@kroah.com>
To: Aaron Gyes <floam@sh.nu>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050329033350.GA6990@kroah.com>
References: <1111886147.1495.3.camel@localhost> <490243b66dc7c3f592df7a7d0769dcb7@mac.com> <20050327181221.GB14502@kroah.com> <1112058277.14563.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112058277.14563.4.camel@localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 05:04:37PM -0800, Aaron Gyes wrote:
> On Sun, 2005-03-27 at 10:12 -0800, Greg KH wrote:
> > No, that is not the general consensus at all.  Please search the
> > archives and the web for summaries of this discussion topic the last
> > time it came up.
> > 
> > greg k-h
> 
> Hi. I've searched the archives about this stuff. It looks like you
> attempted to change the EXPORT_SYMBOL's to EXPORT_SYMBOL_GPL for sysfs
> stuff back in February, and the issue in general has come up many times.

I only tried to change the class_simple code at that time.  This was
because the entire other driver core code was converted by the author of
that code at the same time.  The reason people complained about the
class_simple code was because of vmware and nvidia.

Since then, vmware has stated that they don't even like sysfs and udev,
and dropped support for it entirely.  Also, nvidia has told me that they
do not like udev either, so they don't care about the sysfs code too.

> A few people have made the point that Linus has said that changing
> EXPORT_SYMBOL to EXPORT_SYMBOL_GPL is not okay, that they are supposed
> to start off as EXPORT_SYMBOL_GPL or somesuch. And it seems last time
> you tried it, something made you change it back. 

Yes, I was asked nicely to do so by some people I respect.  Since then,
I sought out the only closed source users of this code that I could
find, and consulted them for what to do.  As mentioned above, neither
company has a problem with me doing this.

Also, the code has undergone a rewrite, fixing many issues, and changing
the way things work to tie more closely into the main driver core code.
As such, the class_simple code is now just gone, there is no such need
for it.  And as such, the new code contains the _GPL markings, as I do
not think that _anyone_ can try to claim that their code would not be a
derived work of Linux who wants to use it (as no other OS has such a
driver model interface.)

> Can you explain this, please?

I hope the above explanation is acceptable.  If you have further
questions, please do not hesitate to ask.  And I would personally like
to thank you for your civil tone.  My current inbox reflects the rants
of people without such civility at this time.

thanks,

greg k-h
