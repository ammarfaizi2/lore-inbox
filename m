Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290839AbSAaCfi>; Wed, 30 Jan 2002 21:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290840AbSAaCf0>; Wed, 30 Jan 2002 21:35:26 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:18659 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290838AbSAaCfQ>;
	Wed, 30 Jan 2002 21:35:16 -0500
Date: Wed, 30 Jan 2002 21:35:14 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*...
Message-ID: <20020130213514.A22862@havoc.gtf.org>
In-Reply-To: <20020130205714.B20698@havoc.gtf.org> <7661.1012442792@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7661.1012442792@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, Jan 31, 2002 at 01:06:32PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 01:06:32PM +1100, Keith Owens wrote:
> On Wed, 30 Jan 2002 20:57:14 -0500, 
> Jeff Garzik <garzik@havoc.gtf.org> wrote:
> >On Thu, Jan 31, 2002 at 12:51:50PM +1100, Keith Owens wrote:
> >> tend not to live very long.  Christoph Hellwig suggested a Makefile
> >> change that prevents kernel code including user space headers, it is
> >> included in kbuild 2.5 and there is a 2.4 version in
> >> 
> >> http://marc.theaimsgroup.com/?l=linux-kernel&m=100321690511549&w=2
> >
> >Patch looks ok to me...  The only thing I wonder is if we should put
> >kernel includes before gcc includes, just in case we want to override
> >something.
> 
> I doubt that is ever a good idea.  The kernel would have to track which
> gcc was being used and work out what to override or duplicate.  Why
> make the kernel any more sensitive to gcc than we have to?

The kernel often has special rules for and usage of gcc.
Why -prevent- the flexibility of doing this?

As soon as a case appears when we might need to care about what the gcc
headers are doing, we will want to do this anyway.


> >I would support putting this in the default cflags for 2.4 and 2.5...
> 
> --nostdinc is the default for kbuild 2.5.  I did not bother sending it
> in for 2.4 because my kbuild 2.5 testing finds the naughty code anyway
> and I send individual bug fixes for the offending files.  There is also
> a risk of breaking existing third party code, I was not willing to take
> that risk on a "stable" series like 2.4.

Understandable...  but I disagree :)

First, we rarely bend over backwards for 3rd party code, and more
importantly we should -never ever- do anything to assist and support
bad code.

	Jeff



