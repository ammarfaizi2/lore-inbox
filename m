Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291340AbSBGVpr>; Thu, 7 Feb 2002 16:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291339AbSBGVph>; Thu, 7 Feb 2002 16:45:37 -0500
Received: from ns.suse.de ([213.95.15.193]:50190 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291333AbSBGVpZ>;
	Thu, 7 Feb 2002 16:45:25 -0500
Date: Thu, 7 Feb 2002 22:45:24 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Brent Cook <busterb@mail.utexas.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Fix for duplicate /proc entries
In-Reply-To: <20020207152233.D6457-100000@ozma.union.utexas.edu>
Message-ID: <Pine.LNX.4.33.0202072243560.26015-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Brent Cook wrote:

> I had problems with loading kernel modules more in mind with this patch.
> Try loading a kernel module that creates a /proc entry and then loading it
> again with a different name. If the original module that created the /proc
> entry is then unloaded, any further attempts to read the remaining proc
> entry leads to a NULL pointer being handed back to the reading process.

"Doctor it hurts when I do this"

> It seems that this return value is handled differently (if at all ;)
> throughout the kernel, so I don't know what effects having another error
> condition might have on other code, such as acpi.

If the other code is doing something dumb, don't be afraid to break it.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

