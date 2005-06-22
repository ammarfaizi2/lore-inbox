Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVFVHv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVFVHv7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVFVHsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:48:39 -0400
Received: from dvhart.com ([64.146.134.43]:42161 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262823AbVFVGdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 02:33:24 -0400
Date: Tue, 21 Jun 2005 23:33:27 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, Gerrit Huizenga <gh@us.ibm.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <256780000.1119422007@[10.10.2.4]>
In-Reply-To: <20050621140441.53513a7a.akpm@osdl.org>
References: <20050621132204.1b57b6ba.akpm@osdl.org><E1Dkpn1-0006va-00@w-gerrit.beaverton.ibm.com> <20050621140441.53513a7a.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Andrew Morton <akpm@osdl.org> wrote (on Tuesday, June 21, 2005 14:04:41 -0700):

> Gerrit Huizenga <gh@us.ibm.com> wrote:
>> 
>> Kexec/kdump has a chance of working reliably.
> 
> IOW: Kexec/kdump has a chance of not working reliably.
> 
> Worried.

Personally I'm more concerned about the design issues - I can't see how
any of the other options are sustainable / workable. Things that require
maintaining their own driver base are just insane. Things that dump from
the panicing kernel are just broken. People want to be able to dump to 
disk / network / flash-ram card / god-knows-what, so we need something
that's flexible.

I don't think kdump is perfect and bug-free yet, but at least it has a 
design that looks like it'll be workable and sustainable through the future. 
Plus it's a small patch on top of kexec, which is useful in it's own right
(for fast reboot, etc) so we get to reuse a lot of code.

We could go into how crashdump itself is important (eg. first time failure 
capture is critical for customers, less downtime, I can ship you better 
data on bugs I find in test, etc, etc) but I kind of assumed most people
were convinced of that by now. Even Linus seemed to think kdump was the
sensible way forward (at KS last year), and he seems to be one of the 
most ardent sceptics of crashdump I've ever met ;-)

M.

