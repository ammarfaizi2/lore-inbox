Return-Path: <linux-kernel-owner+w=401wt.eu-S1751653AbXANUCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbXANUCO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 15:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbXANUCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 15:02:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57604 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751650AbXANUCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 15:02:13 -0500
Date: Sun, 14 Jan 2007 21:01:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Kawai, Hidehiro" <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, james.bottomley@steeleye.com,
       Satoshi OSHIMA <soshima@redhat.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       sugita <yumiko.sugita.yf@hitachi.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] binfmt_elf: core dump masking support
Message-ID: <20070114200157.GA2582@elf.ucw.cz>
References: <457FA840.5000107@hitachi.com> <20061213132358.ddcaaaf4.akpm@osdl.org> <20061220154056.GA4261@ucw.cz> <45A2EADF.3030807@hitachi.com> <20070109143912.GC19787@elf.ucw.cz> <45A74B89.4040100@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A74B89.4040100@hitachi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, you can have it as set of 0-1 "limits"...
> 
> I have come up with a similar idea of regarding the ulimit
> value as a bitmask, and I think it may work.
> But it will be confusable for users to add the new concept of
> 0-1 limitation into the traditional resouce limitation feature.
> Additionaly, this approach needs a modification of each shell
> command.
> What do you think about these demerits?

> The /proc/<pid>/ approach doesn't have these demerits, and it
> has an advantage that users can change the bitmask of any process
> at anytime.

Well... not sure if it is advantage. Semantics of ulimit inheritance
are well given, for example. How is this going to be inherited?

Anyway, yes, I see 0/1 "limits" have bad sides, too, so...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
