Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUCXJcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 04:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUCXJcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 04:32:33 -0500
Received: from hell.org.pl ([212.244.218.42]:17673 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S263166AbUCXJcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 04:32:32 -0500
Date: Wed, 24 Mar 2004 10:32:31 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Michael Frank <mhf@linuxmail.org>
Cc: ncunningham@users.sourceforge.net,
       Dmitry Torokhov <dtor_core@ameritech.net>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040324093231.GA15061@hell.org.pl>
Mail-Followup-To: Michael Frank <mhf@linuxmail.org>,
	ncunningham@users.sourceforge.net,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Pavel Machek <pavel@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz> <200403232352.58066.dtor_core@ameritech.net> <1080104698.3014.4.camel@calvin.wpcb.org.au> <opr5cry20s4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <opr5cry20s4evsfm@smtp.pacific.net.th>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Frank:
> Which reminds me of the "failed to read a chunk" message, the guys who 
> reported
> it got all quiet after telling them to do more badblocks testing without 
> diskcaching or
> using dd to write random data and read them back, so  likely was caused by
> media problems.

I'm not so sure, at least in my case. Sure, badblocks /dev/hda1 reports an
access beyond end, but neither badblocks /dev/hda1 $SIZEOF_HDA1 nor SMART
do. Anyway, the alleged bad blocks are at the end of a 400 MB partition, so
unless swsusp allocated swap randomly, there's hardly any chance I could
hit them with 256 MB RAM and LZF on. But then, this failure was a single
event in my case, while others reported some regularity.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
