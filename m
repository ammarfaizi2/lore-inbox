Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWFLR7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWFLR7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWFLR7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:59:24 -0400
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:57642 "EHLO
	outbound1-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750841AbWFLR7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:59:23 -0400
X-BigFish: V
Message-ID: <448DAB77.2040306@am.sony.com>
Date: Mon, 12 Jun 2006 10:59:19 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] x86 built-in command line
References: <e6k7ak$gpd$1@terminus.zytor.com>
In-Reply-To: <e6k7ak$gpd$1@terminus.zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> b. This patch will override a user-provided command line if one
> exists.  This is the wrong behaviour; instead, the builtin command
> line should only apply if no user-specified command line is present.

I'd prefer that the kernel default command line was appended
to the user-supplied one, instead of replacing it. (Or vice-versa.)
This way I can leave the user-specified command line empty and
get the behaviour described above.  Or, I can choose a few
specific options to come from the bootloader and have others
come from the default command line (in the kernel).

I'm VERY interested in this feature, for purposes of automated
testing on multiple architectures.  I have a test rig that can easily
set the command line at kernel compilation time.  However,
coming up with a mechanism to control command line options on
multiple different bootloaders, for the variety of embedded platforms
I deal with, is very difficult.  Right now this part of my
test rig works on all popular embedded arches except x86.

Eventually, I'd like to automatically test many different
kernel command line options, on multiple platforms.


Regards,
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

