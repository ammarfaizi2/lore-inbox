Return-Path: <linux-kernel-owner+w=401wt.eu-S932812AbWLNPpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812AbWLNPpJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932811AbWLNPpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:45:09 -0500
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:2316 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932812AbWLNPpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:45:07 -0500
X-Greylist: delayed 1055 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 10:45:07 EST
Date: Thu, 14 Dec 2006 16:27:22 +0100
From: thunder7@xs4all.nl
To: Theodore Tso <tytso@mit.edu>, Arjan van de Ven <arjan@infradead.org>,
       Franck Pommereau <pommereau@univ-paris12.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Clarify i386/Kconfig explanation of the HIGHMEM config options
Message-ID: <20061214152721.GA5652@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <458118BB.5050308@univ-paris12.fr> <1166090244.27217.978.camel@laptopd505.fenrus.org> <45813E67.80709@univ-paris12.fr> <1166098747.27217.1018.camel@laptopd505.fenrus.org> <20061214151745.GC9079@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214151745.GC9079@thunk.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Tso <tytso@mit.edu>
Date: Thu, Dec 14, 2006 at 10:17:45AM -0500
> 
> Remove an (incorrect) assertion that NOHIGHMEM is right for more
> users, since most systems are coming with at least 1G of memory these
> days, and even some laptops have up 4G of memory.

Given this (on a system with 1G of memory, this option shouldn't be
used)

>  	  If you are compiling a kernel which will never run on a machine with
> -	  more than 1 Gigabyte total physical RAM, answer "off" here (default
> -	  choice and suitable for most users). This will result in a "3GB/1GB"
> -	  split: 3GB are mapped so that each process sees a 3GB virtual memory
> -	  space and the remaining part of the 4GB virtual memory space is used
> -	  by the kernel to permanently map as much physical memory as
> -	  possible.
> +	  more than 1 Gigabyte total physical RAM, answer "off" here.

wouldn't 

+	  1 Gigabyte or more total physical RAM, answer "off" here.

make clearer that even with 1G memory, you shouldn't use this option?
Since 1G is quite common, we should, IMHO, be clear about that case.

Kind regards,
Jurriaan
-- 
They also played a refreshing rendition of Justin's solo material,
Twilight Home and Ocean Rising, with Michael Dean wailing in the back
while going ballistic on the Djembe. 
	Pax Eternum on a NMA concert at Que Sera, Long Beach, in 2004
Debian (Unstable) GNU/Linux 2.6.19-rc5-mm1 2x4826 bogomips load 1.13
the Jack Vance Integral Edition: http://www.integralarchive.org
