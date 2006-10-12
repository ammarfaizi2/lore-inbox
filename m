Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbWJLBIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbWJLBIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 21:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWJLBIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 21:08:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40633 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965245AbWJLBIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 21:08:53 -0400
Date: Wed, 11 Oct 2006 18:08:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: I/O to block devices
Message-Id: <20061011180844.d7119152.akpm@osdl.org>
In-Reply-To: <452A5115.27596.1451223@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <452A5115.27596.1451223@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Oct 2006 13:39:34 +0200
"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> wrote:

> I'm surprised: To my knowledge I/O to block devices is synchronous (at least write 
> I thought)

Nope.  But the kernel will sync the device on the final close.

Try doing `sleep 10000000 < /dev/sda &' and the run the tests...
