Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbTI1Vke (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 17:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTI1Vke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 17:40:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:42158 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262754AbTI1Vkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 17:40:33 -0400
Date: Sun, 28 Sep 2003 14:41:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: oliver@linux-kernel.at, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test6
Message-Id: <20030928144102.5097ad81.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.21.0309281451160.7085-100000@vervain.sonytel.be>
References: <200309281216.h8SCGWsl026399@indianer.linux-kernel.at>
	<Pine.GSO.4.21.0309281451160.7085-100000@vervain.sonytel.be>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> There's a new architecture-specific routine sched_clock() to be implemented
>  (which was BTW not announced on the secret all-architectures mail alias ;-).

Was too!  On September 18.

I considered providing a default implementation, but really, if the
hardware has a higher resolution timer then sched_clock() should use that. 
Providing a HZ-based default would lessen the likelihood of the Alpha
developers doing this properly.

