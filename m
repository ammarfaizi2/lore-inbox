Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268525AbUHYHsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268525AbUHYHsE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 03:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268528AbUHYHsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 03:48:04 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:32703 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268525AbUHYHr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 03:47:59 -0400
Message-ID: <412C442D.3090107@triplehelix.org>
Date: Wed, 25 Aug 2004 00:47:57 -0700
From: Joshua Kwan <joshk@triplehelix.org>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: rddunlap@osdl.org, lcaron@apartia.fr, linux-kernel@vger.kernel.org
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
References: <412B5B35.7020701@apartia.fr>	<20040824092533.65cb32da.rddunlap@osdl.org>	<20040824113407.287f0408.davem@redhat.com>	<20040825044551.GH1456@alpha.home.local> <20040824233648.53eb7c30.davem@redhat.com>
In-Reply-To: <20040824233648.53eb7c30.davem@redhat.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> I pity the poor fool who wishes to netboot his system using
> a tg3 card and use an nfsroot with Debian.  Kind of hard to
> get the card firmware from the filesystem in that case.

For the record, I made this change to Debian's kernel source, because
the project consensus was that the firmware blobs were not free
according to Debian's Free Software Guidelines.

Now I hope you're also aware that tg3 without the firmware works for
about ~90-95% of all tigon3 based devices.

Anyway, to tell you the truth, I would have preferred not making this
change. But the alternative was impossible: sticking the kernel into our
non-free section. See below for more.

> I guess these debian kernel folks replace the BIOS on their
> system with one they have the sources for as well.

Nope. Good ol' Award is fine enough for me.

Then again, LinuxBIOS would satisfy the need for source, wouldn't it?
;)

> The tg3 firmware is just a bunch of MIPS instructions.
> I guess if I ran objdump --disassemble on the image and
> used the output of that in the tg3 driver and "compiled
> that source" they'd be happy.  And this makes the situation
> even more ludicrious.

I'm curious: run that by debian-legal@lists.debian.org and see what they
say. They're the folks who started all this.

As far as I'm personally concerned, as long as Linus/Marcelo thinks it's
free (i.e. it can be found in BK) and no one but people in Debian have
the boredom/presence of mind/whatever to point out that this breaks our
software guidelines, I find myself siding with the majority who believe
it's free enough. The linux-kernel community seems to be actively
cracking down on blatant GPL violations (see: Linksys WRT54G), and
that's good, but they (perhaps wisely) seem to have overlooked the
supposed firmware-in-file issue, and I figure that does say something.

I'm not clear on the details but what they seem to have deduced is that
as long as the firmware 'variable' is not shipped into Debian as part of
the compiled tg3.o, it's barely Free. See

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=243044

for details of the loophole. To me, it makes no difference...

Interesting to know that it's a "bunch of MIPS instructions."  I'd wager
that eventually, some enterprising, bored hacker would probably come up
with a glorious Free cleanroom implementation of the firmware that you 
need to use a MIPS assembler or C comiler on on at build time.. (AIUI 
there's already some of that stuff in linux-2.6, though they're actually 
the original source code.)

As I said it's all very disgusting (hmm.. déjà vu..) and maybe people 
will stop caring about it someday.

-- 
Joshua Kwan

