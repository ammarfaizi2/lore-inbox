Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWHPXS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWHPXS2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWHPXS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:18:28 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:21479 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751224AbWHPXS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:18:27 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: New version of ClownToolKit
To: Sam Ravnborg <sam@ravnborg.org>, clowncoder <clowncoder@clowncode.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Thu, 17 Aug 2006 01:15:43 +0200
References: <6Kxx5-7PT-7@gated-at.bofh.it> <6KyCM-1w7-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GDUcG-00016M-Nu@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:

> A small nitpick about the way ou build the ekrnel module:
> 
> In mk_and_insmod you can replace:
> make -C /usr/src/linux SUBDIRS=$PWD modules
> with
> LIBDIR=/lib/modules/`uname -r`
> make -C $LIBDIR/source O=$LIBDIR/build SUBDIRS=`pwd` modules
> 
> For a normal kernel installation this will do the right thing.
> source points to the kernel source and build point to the output
> directory (they are often equal but not always).

Please don't tell module authors to unconditionally use `uname -r`.
I frequently build kernels for differentd hosts, and if I don't, I'll
certainly compile the needed modules before installing the kernel.
Therefore /lib/modules/`uname -r` is most certainly the completely
wrong place to look for the kernel source.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
