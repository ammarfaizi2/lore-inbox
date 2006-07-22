Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWGVRAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWGVRAn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 13:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWGVRAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 13:00:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:33526 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750962AbWGVRAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 13:00:42 -0400
From: Bodo Eggert <7eggert@elstempel.de>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Joshua Hudson <joshudson@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Sat, 22 Jul 2006 18:59:45 +0200
References: <6ARGK-19L-5@gated-at.bofh.it> <6B8og-1iB-17@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G4Kpi-0001Os-AK@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Subject: Re: what is necessary for directory hard links
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:

> Joshua Hudson <joshudson@gmail.com> wrote:
>> This patch is the sum total of all that I had to change in the kernel
>> VFS layer to support hard links to directories
> 
> Can't be done, as it creates the possibility of loops.

Don't do that then?

> The "only files can
> be hardlinked" idea makes garbage collection (== deleting of unreachable
> objects) simple: Just check the number of references.
> 
> Detecting unconnected subgraphs uses a /lot/ of memory; and much worse, you
> have to stop (almost) all filesystem activity while doing it.

In order to disconnect a directory, you'd have to empty it first, and after
emptying a directory, it won't be part of a loop. Maybe emtying is the
problem ...


This feature was implemented, and I asume it was removed for a reason.
Can somebody remember?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
