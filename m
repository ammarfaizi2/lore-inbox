Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270173AbTGMIW2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 04:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270174AbTGMIW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 04:22:27 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36539
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270173AbTGMIWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 04:22:25 -0400
Subject: Re: 2.4.22pre3 / pwc / emi disconnect == oops, workaround
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Cooke <mpc@star.sr.bham.ac.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1058024543.8030.3.camel@sage.kitchen>
References: <1058024543.8030.3.camel@sage.kitchen>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058085276.31918.31.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jul 2003 09:34:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-12 at 16:42, Mark Cooke wrote:
> 3. usb.c appears to force a disconnect immediately after #2.
> 4. pwc module warns about a disconnect while open.
> 5. Next call to video_ioctl with handle from #1 causes oops.

pwc driver bug. It must defer its unregister until it closes

