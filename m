Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVCINWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVCINWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 08:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVCINWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 08:22:16 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:24982 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262319AbVCINV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 08:21:28 -0500
Message-ID: <422EF853.7000708@g-house.de>
Date: Wed, 09 Mar 2005 14:21:23 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tony.luck@intel.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: size of /proc/kcore grows?
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Luck wrote:
>
> Take a look at the driver (fs/proc/kcore.c) that creates this pseudo-file.

will do ;)

> Initially the size of the file is set from the size of your memory.
>
> Reading the file has the side-effect of setting up the ELF headers to make
> this look like an ELF file ... in fact a sparse one.  Use "objdump" (with the
> "-p" flag I think) to show the headers, and you'll see which offsets in the file
> correspond to which kernel virtual addresses.

ah, well. i was just curious, why the file on the filesystem did not grow
beyond 4 times of the size of the ram. i just reproduced it on another
machine, booted with "mem=48M" and "dd" tried to write out a file until
E_NOSPACE happens, just as expected.

thank you,
Christian.
-- 
BOFH excuse #133:

It's not plugged in.
