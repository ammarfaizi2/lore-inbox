Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbUBXXSz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbUBXXSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:18:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:58838 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262523AbUBXXSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:18:54 -0500
Date: Tue, 24 Feb 2004 15:20:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ron Peterson <rpeterso@MtHolyoke.edu>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
Message-Id: <20040224152033.0821d537.akpm@osdl.org>
In-Reply-To: <Pine.OSF.4.21.0402241426120.320699-100000@mhc.mtholyoke.edu>
References: <20040224104718.26059b7b.davem@redhat.com>
	<Pine.OSF.4.21.0402241426120.320699-100000@mhc.mtholyoke.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ron Peterson <rpeterso@MtHolyoke.edu> wrote:
>
> I haven't done kernel profiling before.  Did a little googling and this is
> what I think I know (2.4.x)
> 
> In lilo.conf, do append="profile=2" (is 2 a good number?)
> reboot
> echo > /proc/profile
> readprofile -m System.map-2.4.24 (or whatever)

Do this:

- boot with `profile=1'

- make sure that /boot/System.map pertains to the currently-running kernel

sudo readprofile -r
sudo readprofile -M10
sleep 60
sudo readprofile -n -v -m /boot/System.map | sort -n +2 > prof.out

