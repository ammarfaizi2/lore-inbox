Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVCNSzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVCNSzy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVCNSzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:55:54 -0500
Received: from zeus.kernel.org ([204.152.189.113]:15850 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261694AbVCNSzg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:55:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Gn6yDORPKNhjsvP2MTU4PD3I28WBsyQY4c6tBwMbdLDzNCG3E4/mwepxsom0zxFpvXV4NSj/YtceaUYV/duVkOYT4yZqJmiY98xqS7IAeMb0M20FUsFSTImUXsx6Ir2jUPjaoMvJvYzOGq/wlR1QMXw0389nUPalWn57da7Sd3s=
Date: Mon, 14 Mar 2005 19:12:30 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: pavel@ucw.cz, david.lang@digitalinsight.com, davej@redhat.com,
       hirofumi@mail.parknet.co.jp, torvalds@osdl.org, paulus@samba.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Message-Id: <20050314191230.3eb09c37.diegocg@gmail.com>
In-Reply-To: <200503140855.18446.jbarnes@engr.sgi.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz>
	<20050314083717.GA19337@elf.ucw.cz>
	<200503140855.18446.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 1.9.5+svn (GTK+ 2.6.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 14 Mar 2005 08:55:18 -0800,
Jesse Barnes <jbarnes@engr.sgi.com> escribió:

> We already have the 'quiet' option, but even so, I think the kernel is *way* 
> too verbose.  Someone needs to make a personal crusade out of removing 
> unneeded and unjustified printks from the kernel before it really gets better 
> though...

But people who wants to know what has been and what hasn't been detected should
start looking at sysfs, shouldn't them?. dmesg is not reliable *at all*, sometimes
when you rmmod something, it doesn't put anything in dmesg, but it did when it was
loaded, so you'll see some messaje in the printk saying "foo was loaded", but it isn't really
loaded

Personally I don't use dmesg anymore to look "what devices are being handled by the
kernel", just sysfs and /proc files. I only look at dmesg when "something goes wrong"
and it doesn't works properly. IMHO dmesg in linux is just a "debug tool" (unlike the BSDs,
who seem to have very strict rules for dmesg messages) and it's nice that it's verbose,
and it could even be "quiet" by default - people who have problems and can't look at sysfs
could add a "noquiet" boot option or run dmesg if it boots. IIRC is what solaris and other
people do by default. Why should people look at all that "horrid" debug info everytime
they boot, except when they have a problem?
