Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751971AbWCRGPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbWCRGPV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 01:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbWCRGPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 01:15:21 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:53418 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751971AbWCRGPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 01:15:20 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH][RFC] mm: swsusp shrink_all_memory tweaks
Date: Sat, 18 Mar 2006 17:14:23 +1100
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ck@vds.kolivas.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Stefan Seyfried <seife@suse.de>, Greg KH <gregkh@suse.de>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603181556.23307.kernel@kolivas.org> <441B9E5A.1040703@yahoo.com.au>
In-Reply-To: <441B9E5A.1040703@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603181714.23977.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cc'ed GregKH for comment hopefully.

On Saturday 18 March 2006 16:44, Nick Piggin wrote:
> Con Kolivas wrote:
> > I added the suspend_pass member to struct scan_control within an #ifdef
> > CONFIG_PM to allow it to not be unnecessarily compiled in in the
> > !CONFIG_PM case and wanted to avoid having the #ifdefs in vmscan.c so
> > moved it to a header file.
>
> Oh no, that rule thumb isn't actually "don't put ifdefs in .c files", but
> people commonly say it that way anyway. The rule is actually that you
> should put ifdefs in declarations rather than call/usage sites.

There isn't a formal reference to this in the Codingstyle documentation, but 
Greg's 2002 ols presentation says simply says no ifdefs in .c files.

http://www.kroah.com/linux/talks/ols_2002_kernel_codingstyle_talk/html/mgp00031.html

I'm confused now because I've been working very hard to do this with all code.

> You did the right thing there by introducing the accessor, which moves the
> ifdef out of code that wants to query the member right? But you can still
> leave it in the .c file if it is local (which it is).

Once again I'm happy to do the right thing; I'm just not sure what that is.

Cheers,
Con
