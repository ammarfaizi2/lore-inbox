Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWBFIXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWBFIXe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWBFIXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:23:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55525 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750771AbWBFIXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:23:33 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org
Subject: Re: [RFC][PATCH 3/5] Virtualization/containers: UTSNAME
References: <43E38BD1.4070707@openvz.org> <43E38DA9.9040606@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 01:21:13 -0700
In-Reply-To: <43E38DA9.9040606@sw.ru> (Kirill Korotaev's message of "Fri, 03
 Feb 2006 20:06:49 +0300")
Message-ID: <m1r76guccm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am disturbed by the introduction of #defines like current_vps() and
vps_utsname.

Magic lower case #defines are usually a bad idea.  

These defines hide the cost of the operations you are performing.
At that point you might as well name the thing system_utsname
so you don't have to change the code.  

And of course you failed to change several references to
system_utsname.

Eric
