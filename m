Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbTICSVx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264241AbTICST6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:19:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:56991 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264191AbTICSSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:18:20 -0400
Date: Wed, 3 Sep 2003 11:18:18 -0700
From: Greg KH <greg@kroah.com>
To: James Clark <jimwclark@ntlworld.com>
Cc: linux-kernel@vger.kernel.org, rml@tech9.net, root@chaos.analogic.com,
       mochel@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Message-ID: <20030903181818.GB1532@kroah.com>
References: <200309031850.14925.jimwclark@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309031850.14925.jimwclark@ntlworld.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 06:53:01PM +0100, James Clark wrote:
> Following my initial post yesterday please find attached my proposal for a 
> binary 'plugin' interface:
> 
> This is not an attempt to have a Microkernel, or any move away from GNU/OSS 
> software. I believe that sometimes the ultimate goals of stability and 
> portability get lost in the debate on OSS and desire to allow anyone to 
> contribute. It is worth remembering that for every Kernel hacker there must 
> be 1000's of plain users. I believe this proposal would lead to better 
> software and more people using it.
> 
> Proposal
> -----------
> 1. Implement binary kernel 'plugin' interface

And this interface will look like what?
What is wrong with the current kernel API interface?

> 2. Over time remove most existing kernel 'drivers' to use new interface - This 
> is NOT a Microkernel.

"remove"???

> 3. Design 'plugin' interface to be extensible as possible and then rarely 
> remove support from interface. Extending interface is fine but should be done 
> in a considered way to avoid interface bloat. Suggest interface supports 
> dependant 'plugins'
> 4. Allow 'plugins' to be bypassed at boot - perhaps a minimal 'known good' 
> list
> 5. Ultimately, even FS 'plugins' could be created although IPL would be 
> required to load these. 
> 6. Code for Kernel, Interface and 'plugins' would still be GPL. This would not 
> prevent the 'tainted' system idea. 

So "drivers" are a third class citizen?  They don't need to be under the
GPL for some reason?

> Expected Outcomes
> ------------------------
> 
> 1. Make Linux easier to use

How would this help this?  The kernel would get bigger somehow, right?

> 2. The ability to replace even very core Kernel components without a restart.

We can do that today with modules.

> 3. Allow faulty 'plugins' to be fixed/replaced in isolation. No other system 
> impact.

How are you going to isolate parts of the kernel from itself?

> 4. 'Plugins' could create their own interfaces as load time. This would remove 
> the need to pre-populate /dev. 

What?

Ok, I'm just giving up now.

But remember, patches are always welcome.  Please post your code to
implement this system if you come up with some.

Good luck,

greg k-h
