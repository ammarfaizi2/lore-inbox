Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbTDIGmG (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 02:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbTDIGmG (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 02:42:06 -0400
Received: from angband.namesys.com ([212.16.7.85]:20627 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP id S262845AbTDIGmG (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 02:42:06 -0400
Date: Wed, 9 Apr 2003 10:53:39 +0400
From: Oleg Drokin <green@namesys.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.67 - reiserfs go boom.
Message-ID: <20030409105339.A26788@namesys.com>
References: <20030409011802.GD25834@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030409011802.GD25834@suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Apr 09, 2003 at 02:18:02AM +0100, Dave Jones wrote:

> Whilst running fsx.. (Though fsx didn't trigger any error,
> and is still running)..
> buffer layer error at fs/buffer.c:127
> Call Trace:
>  [<c016d260>] __wait_on_buffer+0xd0/0xe0
>  [<c0121760>] autoremove_wake_function+0x0/0x50
>  [<c0121760>] autoremove_wake_function+0x0/0x50
>  [<c02886c8>] reiserfs_unmap_buffer+0x68/0xa0

Andrew Morton said "That's not a bug.  It is errant debugging code." because the page is locked by us,
so buffers are safe.
So I am not looking into this and hoping that somebody will fix the debugging code instead ;)

Bye,
    Oleg
