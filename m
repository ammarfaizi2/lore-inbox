Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbTAUVII>; Tue, 21 Jan 2003 16:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbTAUVII>; Tue, 21 Jan 2003 16:08:08 -0500
Received: from quechua.inka.de ([193.197.184.2]:61134 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S267235AbTAUVIH>;
	Tue, 21 Jan 2003 16:08:07 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
References: <25160.1042809144@passion.cambridge.redhat.com> <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il> <E18a1aZ-0006mL-00@bigred.inka.de> <1042930522.15782.12.camel@laptop.fenrus.com> <E18ai8O-00032u-00@bigred.inka.de> <1043098758.27074.2.camel@laptop.fenrus.com>
Organization: private Linux site, southern Germany
Date: Tue, 21 Jan 2003 22:16:06 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E18b5kc-0003BB-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> back then the argument (not mine btw) was that /usr on a lot of machines
> is RO (I think debian has an option for that) so that sysadmins there

and because of that (among other reasons) my other report about
compiling outside of the source directory...

> compile stuff in /root. /lib/modules however IS standardized and needs
> to be writable to install a new kernel so making a symlink to the real

Only while installing a new kernel. And you install the kernel on the
box it needs to run on, which is not necessarily the box it's compiled
on.

> place there isn't too bad. In addition it already is the only directory
> with per kernel files.. adding a second one was judged not needed. It

Only for stand-alone machines which only ever compile and run one
kernel. You don't need a data center to violate that, you just need
the fairly usual three-boxes home network (one of which is mainly a
router/firewall which has no development environment if only for
security reasons, or because it's a scavenged '486).

> has to be somewhere. /lib/modules/ or /usr/src.. who cares. Linus made
> the final call and everybody complies with it since then, just because
> it doesn't matter THAT much. It just needs to be SOMEWHERE standard and
> /lib/modules suffices so far it seems.

Frankly, I think the main reason is that Linus doesn't care at all
about the kernel build process. We've had a _much_ better solution
already in the 2.5 cycle which was rejected for completely bogus
formal reasons coupled with an explicit "why do we need this at all",
even though it was pointed out over and over again what is broken
currently (or was back then, granted it has improved but not as much
as is desirable and possible).

This blatantly erroneous decision[1] just smells of a blind spot or
carelessness more than careful consideration.

Olaf

[1] it's about of the same category as the original Unix' designers
putting utmp and wtmp in /etc. Linus would never have approved _that_.

