Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030504AbVKPVkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030504AbVKPVkk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbVKPVkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:40:40 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:2988 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1030504AbVKPVkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:40:39 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dave Jones <davej@redhat.com>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Wed, 16 Nov 2005 22:41:23 +0100
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115233201.GA10143@elf.ucw.cz> <20051115234007.GO17023@redhat.com>
In-Reply-To: <20051115234007.GO17023@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511162241.23667.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 16 of November 2005 00:40, Dave Jones wrote:
> On Wed, Nov 16, 2005 at 12:32:01AM +0100, Pavel Machek wrote:
> 
>  > If this goes in, you can still keep using old method... I'll not
>  > remove it anytime soon.
> 
> Ok.
> 
>  > > Even it were not for this, the whole idea seems misconcieved to me
>  > > anyway.
>  > 
>  > ...but how do you provide nice, graphical progress bar for swsusp
>  > without this? People want that, and "esc to abort", compression,
>  > encryption. Too much to be done in kernel space, IMNSHO.
>  
> I'll take "rootkit doesnt work" over "bells and whistles".
> 
> I think most users actually care more about "works" than
> "looks pretty, and then fails spectacularly".

I've been discussing this with Pavel for quite some time and my opinion is
that moving the image-writing and reading functionality of swsusp
to the user space makes sense from the technical point of view.

For example it would allow us to add the image encryption (real, eg.
with a passphrase-protected key), image compression, and image
verification in a rather straightforward way.  These are important
functionalities, at least for some users.

However, I think we should not try to read and/or set up kernel
data structures from the users space.  Instead, we can create an interface
that will allow us to convey the image data and metadata from the
kernel to the user space and vice versa.

Greetings,
Rafael

