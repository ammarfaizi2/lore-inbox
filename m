Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbTDFVth (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbTDFVth (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:49:37 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11920
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263115AbTDFVtg (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 17:49:36 -0400
Subject: Re: PATCH: Fixes for ide-disk.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1049662773.3200.16.camel@laptop-linux.cunninghams>
References: <1049527877.1865.17.camel@laptop-linux.cunninghams>
	 <1049561200.25700.7.camel@dhcp22.swansea.linux.org.uk>
	 <1049570711.3320.2.camel@laptop-linux.cunninghams>
	 <1049641400.963.18.camel@dhcp22.swansea.linux.org.uk>
	 <1049662773.3200.16.camel@laptop-linux.cunninghams>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049662965.1602.34.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 22:02:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-06 at 21:59, Nigel Cunningham wrote:
> Ok. I just figured that if there are two (say) calls to suspend a
> driver, there should be two calls to resume it before it actually is
> resumed. Does the spec say anything about how multiple suspends &
> resumes should be handled?

The IDE layer assumes the power management layer doesn't generate
bogus repeated suspend requests. If it does then lots of drivers
are broken and the core code needs fixing.

If its because there are two different notifiers trying to park
the IDE disk that might make more sense.

However getting this wrong loses data so I will accept no changes to
this code until someone precisely explains what is going on so we
can be sure the fix itself is safe.

