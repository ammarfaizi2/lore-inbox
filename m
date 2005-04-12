Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262969AbVDLV5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbVDLV5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbVDLVyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:54:17 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:44770 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S262969AbVDLVwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:52:35 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [INFO] Kernel strict versioning
To: Sensei <senseiwa@tin.it>, Krzysztof Halasa <khc@pm.waw.pl>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 12 Apr 2005 23:52:19 +0200
References: <3R6fp-7Qs-15@gated-at.bofh.it> <3R71T-4S-15@gated-at.bofh.it> <3Si4Q-Nh-21@gated-at.bofh.it> <3SiRe-1eq-9@gated-at.bofh.it> <3SjNh-1Yq-3@gated-at.bofh.it> <3Ss48-qG-1@gated-at.bofh.it> <3SxGA-5mR-29@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DLTIx-000115-LD@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Franco "Sensei" <senseiwa@tin.it> wrote:
> Krzysztof Halasa wrote:

>> It isn't enough. The same compiler and the same .config - yes. But that
>> means you'd have no progress within, say, 2.6. Only bug fixes.
>> There _is_ a tree like that - 2.6.11.Xs are only bugfixes.
> 
> Ok, this adds a new information. Let me explain what I understand now.
> 
> When a new component is added to the kernel, let's say support for a new
> file system, a .config entry is created (CONFIG_MYFS=y|m). Why is this
> entry breaking compatibility? I mean, symbols still remains the same.
> The addition of symbols is not a breaking point.

A kernel feature may require a different (bigger, slower, ...) internal data
structure, which isn't desired unless you use that feature. Or it will
change the semantics of some functions, e.g. functions being a noop (and
optimized away) for uniprocessor with no highmem will do some important
task on a SMP machine with 4 GB.

>> Asking for one modules dir only is similar to asking for only one
>> /boot/vmlinuz-2.6 kernel file.
> 
> Quite the same, yes. You can still have different kernels of course! By
> the way, another stupid curiosity is why /lib/modules instead of /boot?

Boot vs. bootloader. The same reason that allows lilo.conf to be in /etc

See http://www.pathname.com/fhs/ , too
-- 
Top 100 things you don't want the sysadmin to say:
81. The drive ate the tape but that's OK, I brought my screwdriver.

Friﬂ, Spammer: etfxEdqwnm@good4her.info tech@prancegood.com
