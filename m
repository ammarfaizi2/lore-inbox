Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267447AbTAHGH1>; Wed, 8 Jan 2003 01:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267507AbTAHGH1>; Wed, 8 Jan 2003 01:07:27 -0500
Received: from b.smtp-out.sonic.net ([208.201.224.39]:34509 "HELO
	b.smtp-out.sonic.net") by vger.kernel.org with SMTP
	id <S267447AbTAHGH0>; Wed, 8 Jan 2003 01:07:26 -0500
X-envelope-info: <dhinds@sonic.net>
Date: Tue, 7 Jan 2003 22:16:05 -0800
From: dhinds <dhinds@sonic.net>
To: Joshua Kwan <joshk@ludicrus.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.54-dj1-bk] Some interesting experiences...
Message-ID: <20030107221605.A27650@sonic.net>
References: <20030107172147.3c53efa8.joshk@ludicrus.ath.cx> <20030107175801.A23794@sonic.net> <20030107204303.2dd901ca.joshk@ludicrus.ath.cx> <20030107215630.6f8bd876.joshk@ludicrus.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030107215630.6f8bd876.joshk@ludicrus.ath.cx>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 09:56:30PM -0800, Joshua Kwan wrote:
> Ok, the problem is with scsi.h.
> In a typedef for SCSI LUNs 'u8' is used, but not defined - either
> 'typedef u_int8_t u8' outside of the struct, or changing the
> declaration to u_int8_t works. Thanks Misha...

It isn't a kernel header bug; 'u8' is defined elsewhere.  I'll fix
cardmgr properly; it should not be referencing any kernel header
files.

-- Dave
