Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbTCQTpR>; Mon, 17 Mar 2003 14:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261853AbTCQTpR>; Mon, 17 Mar 2003 14:45:17 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:43397 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S261840AbTCQTpQ>; Mon, 17 Mar 2003 14:45:16 -0500
Date: Mon, 17 Mar 2003 19:56:07 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.20 modem control
Message-ID: <20030317195607.GB11881@mail.jlokier.co.uk>
References: <Pine.LNX.4.53.0303171116160.22652@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0303171116160.22652@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Now, the hang-up sequence appears to be queued. It can (and does)
> happen after the previous terminal owner has expired and another
> owner has opened the device. This makes /dev/ttyS0 useless for remote
> log-ins.
> 
> It needs to be, that a 'close()' of a terminal, configured as a modem,
> cannot return to the caller until after the DTR has been lowered, and
> preferably, after waiting a few hundred milliseconds. Without this,
> once logged in, the modem will never disconnect so a new caller
> can't log in.

Better would be if the hang-up sequence is still queued, but a new
open() is delayed until the hangup has completed.

-- Jamie
