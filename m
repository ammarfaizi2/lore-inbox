Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUENCJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUENCJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 22:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUENCJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 22:09:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:53124 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264737AbUENCJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 22:09:16 -0400
Date: Thu, 13 May 2004 19:08:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Antille Julien <julien.antille@eivd.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keventd takes 99% of CPU when laptop lid is closed
Message-Id: <20040513190842.2cfada4d.akpm@osdl.org>
In-Reply-To: <200405132026.46505.julien.antille@eivd.ch>
References: <200405132026.46505.julien.antille@eivd.ch>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antille Julien <julien.antille@eivd.ch> wrote:
>
> On 2.4.26, 2.6.5 and 2.6.6, the kernel process keventd takes 99% of CPU when 
> my laptop's lid is closed. It comes back to normal when I open it again.
> Laptop is a DELL Inspirion 2650.
> 
> This problem did not occure with <=2.4.25 or <= 2.6.4
> 

Can you please generate a kernel profile?

Boot with the "profile=1" kernel command line option.

sudo readprofile -r
<close lid>
<wait 30 seconds>
<open lid>
sudo readprofile -n -v -m /wherever/System.map | sort -n +2 | tail -40 > foo

And send us foo?

Make sure that you use the System.map which corresponds to the
currently-running kernel.

Thanks.
