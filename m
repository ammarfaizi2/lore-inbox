Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbUD2BDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUD2BDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUD2BDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:03:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:53216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262361AbUD2BBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:01:41 -0400
Date: Wed, 28 Apr 2004 18:00:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: brettspamacct@fastclick.com
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040428180038.73a38683.akpm@osdl.org>
In-Reply-To: <40905127.3000001@fastclick.com>
References: <409021D3.4060305@fastclick.com>
	<20040428170106.122fd94e.akpm@osdl.org>
	<409047E6.5000505@pobox.com>
	<40905127.3000001@fastclick.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brett E." <brettspamacct@fastclick.com> wrote:
>
>  Or how about "Use ALL the cache you want Mr. Kernel.  But when I want 
>  more physical memory pages, just reap cache pages and only swap out when 
>  the cache is down to a certain size(configurable, say 100megs or 
>  something)."

Have you tried decreasing /proc/sys/vm/swappiness?  That's what it is for.

My point is that decreasing the tendency of the kernel to swap stuff out is
wrong.  You really don't want hundreds of megabytes of BloatyApp's
untouched memory floating about in the machine.  Get it out on the disk,
use the memory for something useful.

