Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbTDERdn (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 12:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTDERdn (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 12:33:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29325
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262561AbTDERdm (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 12:33:42 -0500
Subject: Re: PATCH: Fixes for ide-disk.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1049527877.1865.17.camel@laptop-linux.cunninghams>
References: <1049527877.1865.17.camel@laptop-linux.cunninghams>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049561200.25700.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Apr 2003 17:46:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-05 at 08:31, Nigel Cunningham wrote:
> @@ -1527,7 +1527,7 @@
>  	/* set the drive to standby */
>  	printk(KERN_INFO "suspending: %s ", drive->name);
>  	do_idedisk_standby(drive);
> -	drive->blocked = 1;
> +	drive->blocked++;
>  

Drive->blocked is a single bit field. Its not a counting lock. Either
we are blocked or not.

Alan

