Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755189AbWKVPkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189AbWKVPkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 10:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191AbWKVPkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 10:40:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42899 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1755189AbWKVPkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 10:40:42 -0500
Date: Wed, 22 Nov 2006 15:42:30 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] PM: suspend/resume debugging should depend on
 SOFTWARE_SUSPEND
Message-ID: <20061122154230.74889e3d@localhost.localdomain>
In-Reply-To: <20061122152328.GI5200@stusta.de>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
	<Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
	<20061122152328.GI5200@stusta.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This might not have been the original purpose of suspend, but it works 
> quite well, STR is obviously not an alternative, and it doesn't matter 
> much whether it takes a minute.

Suspend to ram at the moment is for the very very brave. Having added
resume quirks to the PCI resume code I've got basic resume behaving on at
two boxes where resume ate the disks. I've now found a third case in
testing where str/resume resumes when using Jmicron 365/366 your IDE disks
swapped over which makes a really nasty mess, and that controllers like
the SIL680 come back from resume misclocked and so on.

Patches for some of these will follow, to go with the pci resume quirk
patch already posted.

Alan
