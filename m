Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVC0RlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVC0RlY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 12:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVC0RlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 12:41:24 -0500
Received: from smtpout.mac.com ([17.250.248.73]:41410 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261224AbVC0RlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 12:41:07 -0500
In-Reply-To: <1111913399.6297.28.camel@laptopd505.fenrus.org>
References: <1111886147.1495.3.camel@localhost> <490243b66dc7c3f592df7a7d0769dcb7@mac.com> <1111913399.6297.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <16d78e9ea33380a1f1ad90c454fb6e1d@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Aaron Gyes <floam@sh.nu>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Date: Sun, 27 Mar 2005 12:40:47 -0500
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 27, 2005, at 03:49, Arjan van de Ven wrote:
>> I think that at the moment the general consensus is that it is ok to 
>> use
>> the Linux kernel APIs (but not the EXPORT_SYMBOL_GPL ones) from binary
>> modules _if_ _and_ _only_ _if_ the driver was originally written
>> elsewhere
>> and ported to the Linux kernel.
>
> I disagree there. Only a few copyright holders of the kernel suggested
> that "previously written elsewhere" would be an exception. I haven't,
> Alan Cox has been very vocal about that he hasn't. I've not seen my
> employer say that it would make that exception either.
>
> And it's a gray area.
> Is it ok if you have 5000 lines from another OS and 0 specific/modified
> for linux (the technical impossibility of this aside)
> Is 4990/10 still good?
> is 4900/100 still good ?
> is 4500/500 still good ?
> is 4000/1000 still good ?
> is 2500/2500 still good ?
> is 2000/3000 still good ?
> is 500/4500 still good ?
>
> if anyone thinks this is a loophole their lawyers better have an answer
> for this...
>
> (and note that I'm not claiming that those 4500 lines are a derived 
> work
> when used elsewhere. But I do consider it a derived work if it's in a
> binary form where it does include linux specific code, and even code
> from the linux kernel via say inlines).



<flame type="Binary Driver Hatred">
NOTE: I *strongly* discourage binary drivers.  They're crap and 
frustrate
poor PowerPC users like me.  Since this is purely a theoretical 
discussion,
and I want to discourage binary crud, this email is Copyrighted:

This email is Copyright (C) 2005 Kyle Moffett.

The remainder of this email is available under the GNU General Public
License, version 2.  See http://www.gnu.org/licenses/gpl.txt for 
details.
THE BELOW MAY NOT BE USED IN A BINARY DRIVER, SO DON'T EVEN THINK ABOUT 
IT!
</flame>



Ok, so what if the _driver_ provides an API like this:

int start_driver(void);
int stop_driver(void);
void register_alloc(void *(*alloc)(unsigned long));
void register_free(void (*free)(void *));
[... more register functions here, generic functionality ...]

And a BSD licensed bit of glue based on that interface that connects the
driver to a dozen different OSen by wrapping or using their interfaces
directly.

Do you think _that's_ legal?  As far as I can see, even that level is
iffy, but it's a murky issue, and I doubt it will be decided one way or
another until people test it in various courts.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


