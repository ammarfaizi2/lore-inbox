Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270291AbTGWNLb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 09:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270295AbTGWNLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 09:11:31 -0400
Received: from rth.ninka.net ([216.101.162.244]:43392 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S270291AbTGWNKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 09:10:42 -0400
Date: Wed, 23 Jul 2003 06:25:41 -0700
From: "David S. Miller" <davem@redhat.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: bgs@callnet.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6-test1 : make *config doesn't work
Message-Id: <20030723062541.74b8f35c.davem@redhat.com>
In-Reply-To: <200307231211.h6NCBoel010001@harpo.it.uu.se>
References: <200307231211.h6NCBoel010001@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 14:11:50 +0200 (MEST)
Mikael Pettersson <mikpe@csd.uu.se> wrote:

> I reported this ages ago, but noone cared to fix it.
> The problem is (a) modpost was changed to reference a SPARC-only
> ELF constant,

Nothing about STT_REGISTER being Sparc specific contributes
to this problem, STT_REGISTER (along with other platform specific
defines) exists in /usr/include/elf.h regardless of which platform
you are actually using.

> (b) modpost is compiled against the system's C
> library headers instead of the kernel's, and (c) older versions
> of glibc don't have this constant defined (at least not on x86).

Please update so that you have an uptodate /usr/include/elf.h file.

Really, that is the fix.
