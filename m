Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUBMK0I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266904AbUBMK0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:26:08 -0500
Received: from [212.28.208.94] ([212.28.208.94]:57862 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266894AbUBMK0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 05:26:05 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Chris Siebenmann <cks@utcc.utoronto.ca>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Fri, 13 Feb 2004 11:26:02 +0100
User-Agent: KMail/1.6.1
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <04Feb13.015940est.41760@gpu.utcc.utoronto.ca>
In-Reply-To: <04Feb13.015940est.41760@gpu.utcc.utoronto.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402131126.02289.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 07.59, Chris Siebenmann wrote:
> You write:
> | Oh, I wasn't thinking of fixing *every* application out there, but
> | making the kernel api's convert between the user locale and the file
> | system locale, thus restricting the problems to places that can be
> | fixed.
> 
>  Why should the kernel have any idea about locales, or care? (We've just
> had an illustration, in this very thread, about why bits of the kernel
> caring about locales is dangerous.)
We have also explained why it's a problem and why "something" should care. 
The problem is clear, the solution is less clear. Some file systems already try to 
to handle the issue because the fs itself define the character set. That's the
argument for solving the issue with other file systems the same way. It's also only 
the fs media that can reliably know this since media are movable these days.

>  Making the kernel convert between character sets also requires as a
> corollary that the kernel know about all of the character sets, which is
> both dangerous and liable to expand one's kernel impressively.
That's NLS support, which is already there. Conceivably this could be
a compile-time option for the file systems that due legacy do not state
what character set/encoding is to be used so the system could be tuned
for use in a homogeneous environment w.r.t locale.

>  Declaring that the kernel operates in a fixed locale amounts to
> declaring that it will reject certain byte sequences for filenames
> because it doesn't like how they smell, without clear technical need
> for it. People generally object to their kernel restricting them for
> such reasons.

The needs are not "technical", they are "user" needs. (I hear them laughing
in Redmond).

-- robin
