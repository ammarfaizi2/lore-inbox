Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVFVOq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVFVOq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVFVOpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:45:02 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:16740 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261330AbVFVOnQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:43:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ftleHJ2TNjfaLBLCsQr9l22Nvdn8ldFpHO5/5x1S3yF4KzI3NJoWOD76o7a4/fD+lsIuhwUMjxf5to1H/HAWy2EZrky7+/PxAndTZvDZu/gEEYVkJc6YKpIbk9xAQupHW/Vlv5AseixeTsZ9VG5yKRs7eVQzFPU/sHthnrBgwv8=
Message-ID: <a4e6962a05062207435dd16240@mail.gmail.com>
Date: Wed, 22 Jun 2005 09:43:07 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Cc: Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050621220619.GC2815@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	 <20050621142820.GC2015@openzaurus.ucw.cz>
	 <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
	 <20050621220619.GC2815@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/05, Pavel Machek <pavel@ucw.cz> wrote:
> >
> > An emotional argument again.  What's "strange" about it?
> 
> Not so emotional argument...
> 
> System where users can mount their own filesystems should not be
> called "Unix" any more. It introduces new mechanism, similar to
> ptrace.

I think that's a rather severe statement.   I don't see allowing user
mounts damaging standard UNIX system semantics as long as certain
rules are followed.   After all, user-mounts and private name spaces
are what the original authors of UNIX went on to develop.

> It restricts root in ways not seen before. How is
> updatedb/locate supposed to work on system with this? How is it going
> to interact with backup tools?
>

I think requiring user-mounts to be in private name spaces solves many
of these issues -- you don't have to worry about system daemons and/or
other users wandering into synthetic file systems.

         -eric
