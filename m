Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132887AbRDQVo5>; Tue, 17 Apr 2001 17:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132880AbRDQVon>; Tue, 17 Apr 2001 17:44:43 -0400
Received: from ns.suse.de ([213.95.15.193]:60684 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132881AbRDQVoR>;
	Tue, 17 Apr 2001 17:44:17 -0400
Date: Tue, 17 Apr 2001 23:43:39 +0200
From: Andi Kleen <ak@suse.de>
To: Marty Leisner <mleisner@eng.mc.xerox.com>
Cc: linux-kernel@vger.kernel.org, leisner@rochester.rr.com
Subject: Re: kernel threads and close method in a device driver
Message-ID: <20010417234339.A18288@gruyere.muc.suse.de>
In-Reply-To: <200104172104.RAA08013@mailhost.eng.mc.xerox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104172104.RAA08013@mailhost.eng.mc.xerox.com>; from mleisner@eng.mc.xerox.com on Tue, Apr 17, 2001 at 05:04:28PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 05:04:28PM -0400, Marty Leisner wrote:
> 	open device
> 	do IOCTL (spinning a kernel thread and doing initialization)
> 
> There is currently an IOCTL which short-circuits to the close method.
> Turns out it seems necessary to do this IOCTL -- close never gets 
> invoked.

Call daemonize() in the kernel thread.

-Andi
