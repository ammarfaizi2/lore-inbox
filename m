Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbTCQNi7>; Mon, 17 Mar 2003 08:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261692AbTCQNi6>; Mon, 17 Mar 2003 08:38:58 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:58377 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261683AbTCQNi6>; Mon, 17 Mar 2003 08:38:58 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303171351.h2HDpmN1001061@81-2-122-30.bradfords.org.uk>
Subject: Re: Read Hat 7.3 and 8.0 compilation problems
To: davej@codemonkey.org.uk (Dave Jones)
Date: Mon, 17 Mar 2003 13:51:48 +0000 (GMT)
Cc: hus@design-d.de, linux-kernel@vger.kernel.org
In-Reply-To: <20030317134635.GA436@suse.de> from "Dave Jones" at Mar 17, 2003 12:46:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Are you using the stock rh kernel sources? Did you install the
>  > glibc-kernheaders RPM? This contains severe RedHat braindamage:
>  > /usr/include/{asm,linux} aren't links into the kernel source tree,
>  > but directly installed. Remove the rpm and create the soft links
>  > to /usr/src/linux.
> 
> You have this completely backwards. /usr/include/{asm,linux} are
> the headers from the kernel that the glibc was compiled against.
> They should NOT never ever be symlinks to anywhere, but glibc's
> own copies of the headers.

Personally, I prefer:

/usr/local/-architecture-/include/sys-include/asm-architecture
/usr/local/-architecture-/include/sys-include/linux

If you install a lot of cross compilers, you might find that that
layout is the most logical.

> This is not 'RedHat braindamage', it's the way things should be.
> Making them symlinks is the only braindamage here.

Not sure if RedHat does this or not, but something that I would always
recommend is avoided, is assuming that /usr/src/linux is a symbolic
link to the current kernel source code.

John.
