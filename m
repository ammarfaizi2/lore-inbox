Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290829AbSAaCG6>; Wed, 30 Jan 2002 21:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290830AbSAaCGs>; Wed, 30 Jan 2002 21:06:48 -0500
Received: from rj.SGI.COM ([204.94.215.100]:2436 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S290829AbSAaCGm>;
	Wed, 30 Jan 2002 21:06:42 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*... 
In-Reply-To: Your message of "Wed, 30 Jan 2002 20:57:14 CDT."
             <20020130205714.B20698@havoc.gtf.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 Jan 2002 13:06:32 +1100
Message-ID: <7661.1012442792@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002 20:57:14 -0500, 
Jeff Garzik <garzik@havoc.gtf.org> wrote:
>On Thu, Jan 31, 2002 at 12:51:50PM +1100, Keith Owens wrote:
>> tend not to live very long.  Christoph Hellwig suggested a Makefile
>> change that prevents kernel code including user space headers, it is
>> included in kbuild 2.5 and there is a 2.4 version in
>> 
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=100321690511549&w=2
>
>Patch looks ok to me...  The only thing I wonder is if we should put
>kernel includes before gcc includes, just in case we want to override
>something.

I doubt that is ever a good idea.  The kernel would have to track which
gcc was being used and work out what to override or duplicate.  Why
make the kernel any more sensitive to gcc than we have to?

>I would support putting this in the default cflags for 2.4 and 2.5...

--nostdinc is the default for kbuild 2.5.  I did not bother sending it
in for 2.4 because my kbuild 2.5 testing finds the naughty code anyway
and I send individual bug fixes for the offending files.  There is also
a risk of breaking existing third party code, I was not willing to take
that risk on a "stable" series like 2.4.

