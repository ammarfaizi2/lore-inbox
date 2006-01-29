Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWA2NSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWA2NSg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 08:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWA2NSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 08:18:36 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:36513 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1750972AbWA2NSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 08:18:35 -0500
Date: Sun, 29 Jan 2006 14:18:15 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Christoph Hellwig <hch@infradead.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060129131815.GB21386@hardeman.nu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Christoph Hellwig <hch@infradead.org>, keyrings@linux-nfs.org,
	linux-kernel@vger.kernel.org
References: <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu> <1138466271.8770.77.camel@lade.trondhjem.org> <20060128165732.GA8633@hardeman.nu> <1138504829.8770.125.camel@lade.trondhjem.org> <20060129113320.GA21386@hardeman.nu> <20060129122901.GX3777@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20060129122901.GX3777@stusta.de>
User-Agent: Mutt/1.5.11
X-SA-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 01:29:01PM +0100, Adrian Bunk wrote:
>You are taking the wrong approach.
>
>The _only_ question that matters is:
>Why is it technically impossible to do the same in userspace?
>
>If it's technically possible to do the same in userspace, it must not be 
>done in the kernel.

It may not be impossible, but adding support for dsa key types to the 
in-kernel key management is something like 150 lines of code once the 
dsa crypto-ops are implemented. I think you get a lot of convenience 
for those 150 lines (and yes, I do believe that convenience is also a 
valid argument for adding functionality). Having to protect against all 
attack vectors is much harder in user-space than in kernel-space.

As for the addition of the dsa crypto-ops, you still haven't answered 
the question of how signed modules and/or binaries can be implemented
in userspace...

>That's exactly the reason why e.g. kernel 2.6 does not contain a 
>webserver.

Apples and oranges

Re,
David
