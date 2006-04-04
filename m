Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWDDFNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWDDFNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 01:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWDDFNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 01:13:25 -0400
Received: from xenotime.net ([66.160.160.81]:35472 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964933AbWDDFNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 01:13:25 -0400
Date: Mon, 3 Apr 2006 22:15:37 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: menuconfig search (Re: [rfc] fix Kconfig, hotplug_cpu is needed for
 swsusp)
Message-Id: <20060403221537.79bb3af9.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0603301022400.30783@yvahk01.tjqt.qr>
References: <20060329220808.GA1716@elf.ucw.cz>
	<200603300936.22757.ncunningham@cyclades.com>
	<20060329154748.A12897@unix-os.sc.intel.com>
	<200603300953.32298.ncunningham@cyclades.com>
	<Pine.LNX.4.61.0603301022400.30783@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006 10:24:30 +0200 (MEST) Jan Engelhardt wrote:

> >Most people don't seem to know 
> >about '/' in make menuconfig.

That's a shame.

> I find it very confusing to use, since it returns too verbose text to skim 
> through. Probably the search function should be split into "only search 
> titles[*]" and "search description too".

Re verbosity:  do you know that menuconfig search (/) takes regular
expressions?  That could help someone limit the amount of output
from it.

Can you give an example of being too verbose?

>   config UNIX
>     bool "Unix socket"            <-- that's a "title", as in menuconfig

The search function of menuconfig (currently) works in the namespace of
CONFIG_ symbols.  It will search for a regex in the symbol tables.
Yes, someone could modify it to search thru the prompt strings of the
symbols.  I don't know if that would help or not.

I have just modified menuconfig search to make displaying the
Selects: and Selected by: output be an option (actually it's a
different search command (\) to not see those lines.
Would that help any regarding verbosity?

The patch is here if you would care to try it:
  http://www.xenotime.net/linux/patches/menuconfig-search2.patch

---
~Randy
