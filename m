Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbTDIA2v (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 20:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbTDIA2v (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 20:28:51 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:17424 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S262653AbTDIA2u (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 20:28:50 -0400
Date: Wed, 9 Apr 2003 02:40:24 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <b6vnig$q86$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.44.0304090225440.12110-100000@serv>
References: <20030408195305.F19288@almesberger.net>
 <Pine.LNX.4.44.0304081607060.5766-100000@dlang.diginsite.com>
 <b6vnig$q86$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8 Apr 2003, H. Peter Anvin wrote:

> So far, *none* of the schemes used for dynamics have gotten it right.
> They just ignore a fair number of the problems.  People keep focusing
> on disks, and they are nearly uniformly the almost-trivial case in
> comparison with especially character devices, where you don't have the
> layer of indirection called /etc/fstab, persistent labels, etc.

http://marc.theaimsgroup.com/?l=linux-kernel&m=95547434315472&w=2

> a) There are, genuinely, systems with more than 65,536 devices or
> anonymous mounts.  That rules out the current dev_t just by itself.

Absolutely nobody denies that we need a larger dev_t. It's really a poor 
argumentation that you have to come up with this.

> b) Despite the fact that people have tried since the mid-90's, we
> still don't have a sane way to manage such dynamicity.

Maybe you didn't notice, that only now the block device layer is clean 
enough to go dynamic. Maybe you didn't notice that scsi devices are 
already dynamically numbered and that there are already user space tools 
to translate them to constant device names.

> Given that it has taken, literally, 8 years to get to this point, and
> based on collective global experience with numberspaces, I'm arguing
> for enlarging it far more than anyone can currently imagine being
> necessary.

And since more than 8 years Linus is trying to tell you that static 
device numbers don't work. When do you start to listen?

bye, Roman

