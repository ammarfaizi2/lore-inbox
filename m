Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWDHImz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWDHImz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 04:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWDHImz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 04:42:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:4766 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751401AbWDHImy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 04:42:54 -0400
Date: Sat, 8 Apr 2006 10:42:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: menuconfig search (Re: [rfc] fix Kconfig, hotplug_cpu is needed
 for swsusp)
In-Reply-To: <20060403221537.79bb3af9.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0604081030201.21887@yvahk01.tjqt.qr>
References: <20060329220808.GA1716@elf.ucw.cz> <200603300936.22757.ncunningham@cyclades.com>
 <20060329154748.A12897@unix-os.sc.intel.com> <200603300953.32298.ncunningham@cyclades.com>
 <Pine.LNX.4.61.0603301022400.30783@yvahk01.tjqt.qr>
 <20060403221537.79bb3af9.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I find it very confusing to use, since it returns too verbose text to skim 
>> through. Probably the search function should be split into "only search 
>> titles[*]" and "search description too".
>
>Re verbosity:  do you know that menuconfig search (/) takes regular
>expressions?

Regexes are not mentioned in the "Help" menu.

>That could help someone limit the amount of output
>from it.
>Can you give an example of being too verbose?

/ UNIX
 Symbol: UNIX [=y]
 Prompt: Unix domain sockets
   Defined at net/unix/Kconfig:5
   Depends on: NET
   Location:
     -> Networking
       -> Networking support (NET [=y])
         -> Networking options

 Symbol: UNIXWARE_DISKSLICES ...
  ...


What would be more useful:
 UNIX
   Unix domain sockets
   Networking > Networking Support > Networking options

 UNIXWARE_DISKSLICES
   Unixware slices support
   File systems > Advanced ...

I.e. strip the Defined and Depends lines and crunch the Location lines inasfar
as that the full width of the window is used (break at col 70).

 DEEP_FS
   Just a symbol
   File systems > Advanced filesystems > Very advanced filesystems >\n
   Extremely advanced filesystems > Deep filesystem


>I have just modified menuconfig search to make displaying the
>Selects: and Selected by: output be an option (actually it's a
>different search command (\) to not see those lines.
>Would that help any regarding verbosity?

At the moment, entering e.g. UNIX in both the / and \ menus return the very 
same output. Bug?

The \ should include everything what the original / had, plus the symbol
description ("Say Y here if ....").



Jan Engelhardt
-- 
