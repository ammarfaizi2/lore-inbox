Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbTEKVu2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 17:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbTEKVu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 17:50:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13973
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261251AbTEKVu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 17:50:28 -0400
Subject: Re: [PATCH] restore sysenter MSRs at resume
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305111158500.12955-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305111158500.12955-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052687076.30359.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 May 2003 22:04:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-05-11 at 20:01, Linus Torvalds wrote:
> However, the fact that the SYSENTER MSR needs to be restored makes me
> suspect that the other MSR/MTRR also will need restoring. I don't see 
> where we'd be doing that, but it sounds to me like it should be done here 
> too..

Some laptops certainly require the MTRR restore to happen. MSRs are
mostly less of a problem because the profiling stuff is broken on PIII
unless you disable/re-enable it across power save anyway.

Some laptops also lose all the AGP settings in the chipset.

