Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVCGIaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVCGIaF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVCGIaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:30:04 -0500
Received: from ns.suse.de ([195.135.220.2]:26783 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261691AbVCGI3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:29:49 -0500
Message-ID: <422C0228.1000709@suse.de>
Date: Mon, 07 Mar 2005 08:26:32 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Niehusmann <jan@gondor.com>
Cc: len.brown@intel.com, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: bouncing keys and skipping sound with 2.6.11
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org> <20050228184414.GA31929@gondor.com> <20050302200632.GA24529@gondor.com> <20050306185539.GA2149@gondor.com>
In-Reply-To: <20050306185539.GA2149@gondor.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann wrote:

> By trying different kernel versions, I traced down the problem to the
> changes introduced between linux-2.6.11-rc2-bk9 and
> linux-2.6.11-rc2-bk10, and, more specifically, to the ACPI changes
> within that patch. (Therefore the Cc: to Len Brown, who wrote or
> submitted most of these changes, as far as I can tell from the
> changelog)

I bet you have CONFIG_ACPI_DEBUG enabled. Disable it or try to put
#define ACPI_ENABLE_OBJECT_CACHE 1
at the end of include/acpi/acpi.h (before the last #endif)
This fixed it for me (and some others).
There is also a patch for a "CONFIG_ACPI_DEBUG_LITE" from Thomas
Renninger on the acpi-devel list, which leaves some of the debugging in,
but disables the worst offenders IIUC.

Hope that helps,

     Stefan

