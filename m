Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264767AbSL0Dzk>; Thu, 26 Dec 2002 22:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264771AbSL0Dzk>; Thu, 26 Dec 2002 22:55:40 -0500
Received: from almesberger.net ([63.105.73.239]:38411 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S264767AbSL0Dzk>; Thu, 26 Dec 2002 22:55:40 -0500
Date: Fri, 27 Dec 2002 01:03:38 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Anomalous Force <anomalous_force@yahoo.com>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: holy grail
Message-ID: <20021227010338.A1406@almesberger.net>
References: <20021227005118.18686.qmail@web13202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021227005118.18686.qmail@web13202.mail.yahoo.com>; from anomalous_force@yahoo.com on Thu, Dec 26, 2002 at 04:51:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anomalous Force wrote:
> a hot swap kernel would be something like the holy grail of kernel
> hacking.

:-) This comes up every once in a while. The closest approximation
you have for this is swsusp. But you'd of course want to start a
non-identical kernel. And that's where the hard problems lie.

An older or newer kernel would have different data structures, and
possibly even data structures which are arranged in a different way
(e.g. a hash becomes some kind of tree, etc.). So you'd need some
translation mechanism that "upgrades" or "downgrades" all kernel
data, including all pointers and offsets that may be sitting
around somewhere. Good luck :-)

Your best bet would be to use a system that already implements some
form of checkpointing or process migration, and use this to
preserve user space state across kexec reboots. openMosix may be
relatively close to being able to do this for general user space.
(I don't know what openMosix currently can do, but many of the
problems they need to solve are similar in nature.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
