Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263869AbUFBThX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbUFBThX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 15:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbUFBThX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 15:37:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47282 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263869AbUFBThW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 15:37:22 -0400
Date: Wed, 2 Jun 2004 20:37:20 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040602193720.GQ12308@parcelfarce.linux.theplanet.co.uk>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl> <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org> <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org> <Pine.LNX.4.58.0406020724040.22204@bigblue.dev.mdolabs.com> <20040602182019.GC30427@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406021124310.22742@bigblue.dev.mdolabs.com> <20040602185832.GA2874@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040602185832.GA2874@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 08:58:32PM +0200, Jörn Engel wrote:
> Note the "in the most general case" part.  You can get things right if
> you make some assumptions and those assumptions are actually valid.
> In my case the assumptions are:
> 1. all relevant function pointers are stuffed into some struct and

Wrong.  They are often passed as arguments to generic helpers, without
being ever put into any structures.
