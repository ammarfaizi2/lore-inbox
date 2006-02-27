Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWB0XNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWB0XNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 18:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbWB0XNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 18:13:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38371 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751767AbWB0XNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 18:13:33 -0500
Date: Mon, 27 Feb 2006 15:12:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: col-pepper@piments.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: o_sync in vfat driver
Message-Id: <20060227151230.695de2af.akpm@osdl.org>
In-Reply-To: <op.s5nkafhpj68xd1@mail.piments.com>
References: <op.s5lrw0hrj68xd1@mail.piments.com>
	<20060226165114.e87fe056.akpm@osdl.org>
	<op.s5nkafhpj68xd1@mail.piments.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

col-pepper@piments.com wrote:
>
> That would not seem to be the case at least on MS systems. I had a freind  
>  do some timings copying a large group of files to a 128M usb flash device.
>  There was an arbitary mix of files including many small files and some  
>  larger files, one in excess of 50MB.
> 
>  suse10 default 4m10
>  win2k 2m30
>  suse w/o sync 30s
> 
>  The suse test was drag and drop in konqueror , the other dnd in windows  
>  explorer.

We don't know that the same number of same-sized write()s were happening in
each case.

There's been some talk about implementing fsync()-on-file-close for this
problem, and some protopatches.  But nothing final yet.

