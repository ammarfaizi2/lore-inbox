Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWBGBkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWBGBkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWBGBkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:40:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14268 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964927AbWBGBkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:40:03 -0500
Date: Mon, 6 Feb 2006 17:39:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: implement swap prefetching
Message-Id: <20060206173936.1a331291.akpm@osdl.org>
In-Reply-To: <200602071229.25793.kernel@kolivas.org>
References: <200602071028.30721.kernel@kolivas.org>
	<20060206163842.7ff70c49.akpm@osdl.org>
	<200602071229.25793.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
>  > > +/* Last total free pages */
>  > > +static unsigned long last_free = 0;
>  > > +static unsigned long temp_free = 0;
>  >
>  > Unneeded initialisation.
> 
>  Very first use of both of these variables depends on them being initialised.

All bss is initialised to zero at bootup.  So all the `= 0' is doing here
is moving these variables from .bss to .data, and taking up extra space in
vmlinux.

