Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273541AbSISW3W>; Thu, 19 Sep 2002 18:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273440AbSISW2R>; Thu, 19 Sep 2002 18:28:17 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:54913 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S273541AbSISWZy>; Thu, 19 Sep 2002 18:25:54 -0400
Date: Fri, 20 Sep 2002 00:30:58 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
To: linux-kernel@vger.kernel.org
Cc: robn@verdi.et.tudelft.nl
Subject: ext3 fs: no userspace writes == no disk writes ?
Message-ID: <20020920003058.A4850@verdi.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a question about ext3 write activity.

I am considering using an ext3 fs on a CompactFlash disk for my
data-logging application (power can disapear anytime).
The quantity & frequency of the data logged itself is not a
problem at all considering flash wear.

But I'm a bit worried about the kernel/ext3 doing regular writes
by itself even when there are no userspace writes.  (worries are
partially caused by memories from long time ago about idle laptop
doing regular writes on disk).

Anybody out there who knows how this works ?

Can I use an ext3 fs without having regular "automatic" writes to
the device it is located on ?  (and thus not destroy my CompactFlash
devices !)

	greetings,
	Rob van Nieuwkerk


PS1: of course nothing from userspace should write frequently to
    the fs, and if there is regular read-activity the fs should
    be mounted with "noatime")

PS2: yes, I know that jffs exists
