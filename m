Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264078AbTDOVPQ (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264080AbTDOVPQ 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:15:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48320
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264078AbTDOVPP (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 17:15:15 -0400
Subject: Re: PATCH: MTRR save and restore.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Richard Gooch <rgooch@ras.ucalgary.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@clear.net.nz>
In-Reply-To: <Pine.LNX.4.44.0304151313260.912-100000@cherise>
References: <Pine.LNX.4.44.0304151313260.912-100000@cherise>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050438520.28591.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2003 21:28:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-15 at 21:18, Patrick Mochel wrote:
> MTRRs are one interface to an x86 CPU. CPUs are already represented in the
> device tree. The proper thing to do would be to have the CPU suspend/ 
> resume methods save and restore the MTRRs. It still requires an #ifdef in 
> the CPU code, but with a little work, could be massaged down a ways. 

Also it has to be done kernel side for SMP because having mismatched
MTRRs between processors is unsafe, yet lots of BIOSen get it wrong.


