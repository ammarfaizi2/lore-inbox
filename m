Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272423AbTGaHPx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 03:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272430AbTGaHPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 03:15:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:49312 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272423AbTGaHPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 03:15:52 -0400
Date: Thu, 31 Jul 2003 00:16:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: lista1@telia.com, linux-kernel@vger.kernel.org
Subject: Re: Disk performance degradation
Message-Id: <20030731001618.757ab293.akpm@osdl.org>
In-Reply-To: <3F28BE65.9060809@gts.it>
References: <20030729182138.76ff2d96.lista1@telia.com>
	<3F2786E9.9010808@gts.it>
	<20030730035524.65cfc39a.akpm@osdl.org>
	<3F27ECFA.5020005@gts.it>
	<20030730114428.7e629895.akpm@osdl.org>
	<3F28BE65.9060809@gts.it>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir <s.rivoir@gts.it> wrote:
>
>  > How much more memory is X using when DRI is loaded?
> 
>  Here attached you'll find the vmstats, 2.4.21, 2.6.0 with DRI and 2.6.0
>  w/o DRI. 2.4.21 and 2.6.0-nodri are more or less the same...

wow, it seems to have taken 24 megabytes.

You may get nicer performance out of that little machine by decreasing
/proc/sys/vm/swappiness.  I have the feeling that the current default of
60% is about right for 256M machines, but too small for larger machines,
too large for smaller machines.   I use 85% on a 1G desktop machine.


