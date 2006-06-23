Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWFWNKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWFWNKE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWFWNKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:10:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57519 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964812AbWFWNKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:10:03 -0400
Subject: Re: [PATCH][RFC] kill TTY_DONT_FLIP
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1151002928.15500.21.camel@amdx2.microgate.com>
References: <1151002928.15500.21.camel@amdx2.microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jun 2006 14:25:37 +0100
Message-Id: <1151069137.4549.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-22 am 14:02 -0500, ysgrifennodd Paul Fulghum:
> Kill TTY_DONT_FLIP flag, which is set in n_tty read_chan().
> This flag is only used by the N_TTY line discipline. It was added
> in the 2.1.X development series. Its original purpose seems
> to be protecting the N_TTY read buffer state (tty->read_tail, etc)
> from conflicting access by read_chan (reads from N_TTY read buffer)
> and the flip buffer code (writes to N_TTY read buffer
> via n_tty_receive_buf).
> 
> The spin lock tty->read_lock was subsequently added to
> protect the N_TTY read buffer. After reviewing the
> tty code, I see no other state that is protected
> by TTY_DONT_FLIP.

Looks good to me on a first review.

Alan

