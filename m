Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161205AbWG1RfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161205AbWG1RfQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161202AbWG1RfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:35:16 -0400
Received: from xenotime.net ([66.160.160.81]:27597 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161199AbWG1RfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:35:15 -0400
Date: Fri, 28 Jul 2006 10:37:56 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: sam@ravnborg.org, mec@shout.net, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: Linguistic fixes for Documentation/kbuild/
Message-Id: <20060728103756.9f2d8507.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0607272208110.29115@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0607272208110.29115@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006 22:14:29 +0200 (MEST) Jan Engelhardt wrote:

> Hello,
> 
> 
> I have done a look-through through Documentation/kbuild/ and my corrections 
> (proposed) are attached. It is bzipped because the uncompressed diff is 
> 41KB and may have get stuck on the magic list limit (30 or 40, I believe 40).

or 80 or 100 KB ?  Certainly more than 40 KB.

> Cc'ed are original author Michael (responsible for comitting changes to 
> these files?), Sam (kbuild maintainer), Adrian (-trivial maintainer).
> 
> Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
> 
>  kconfig-language.txt |   12 +--
>  makefiles.txt        |  184 ++++++++++++++++++++++++++-------------------------
>  modules.txt          |  119 ++++++++++++++++----------------
>  3 files changed, 160 insertions(+), 155 deletions(-)
> 
> I have noticed more inconsistencies ("architecture-specific" vs 
> "architecture specific"), mixed use of American -z- and British -s- 
> (such as customize/customise), and more. This patch is a simple start that 
> does not go into language pickyness. Except maybe for commas :)

architecture-specific when used as an adjective.


makefiles.txt:

-	This tell kbuild that there is one object in that directory named
+	This tell kbuild that there is one object in that directory, named

s/tell/tells/

-	In the above example cflags-y will be assinged the the option
+	In the above example, cflags-y will be assinged the the option

s/assigned/assigned/
s/the the/the/

-	cc-option is used to check if $(CC) support a given option, and not
+	cc-option is used to check if $(CC) supports a given option, and not
 	supported to use an optional second option.

maybe "and if not supported, to use an optional second argument." ?

-	A typcal pattern in a Kbuild file lok like this:
+	A typcal pattern in a Kbuild file looks like this:

s/typcal/typical/

 	So if a config symbol evaluate to 'm', kbuild will still build

evaluates ?

-	the binary. In other words Kbuild handle hostprogs-m exactly
-	like hostprogs-y. But only hostprogs-y is recommend used
-	when no CONFIG symbol are involved.
+	the binary. In other words, Kbuild handles hostprogs-m exactly
+	like hostprogs-y. But only hostprogs-y is recommended to be used
+	when no CONFIG symbols are involved.

    - This includes building boot records
-   - Preparing initrd images and the like
+   - Preparing initrd images and thelike

"the like" was good.

-	$(head-y) list objects to be linked first in vmlinux.
-	$(libs-y) list directories where a lib.a archive can be located.
-	The rest list directories where a built-in.o object file can be located.
+	$(head-y) lists objects to be linked first in vmlinux.
+	$(libs-y) lists directories where a lib.a archive can be located.
+	The rest lists directories where a built-in.o object file can be
+	located.

"rest" looks plural to me there, so "list" is OK IMO.

-	When the rule is evaluated it is checked to see if any files
-	needs an update, or the commandline has changed since last
+	When the rule is evaluated, it is checked to see if any files
+	needs an update, or the command line has changed since the last

s/needs/need/
(or "file needs")

-	$(targets) are assinged all potential targets, herby kbuild knows
+	$(targets) are assinged all potential targets, by which kbuild knows

assigned


---
~Randy
