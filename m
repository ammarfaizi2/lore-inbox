Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280931AbRKTGEi>; Tue, 20 Nov 2001 01:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280932AbRKTGE3>; Tue, 20 Nov 2001 01:04:29 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:29459
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S280931AbRKTGEO>; Tue, 20 Nov 2001 01:04:14 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200111200541.fAK5f9J28091@www.hockin.org>
Subject: Re: LOBOS (kexec)
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 19 Nov 2001 21:41:08 -0800 (PST)
Cc: lm@bitmover.com (Larry McVoy),
        dervishd@jazzfree.com (RaXlNXXez de Arenas Coronado),
        linux-kernel@vger.kernel.org
In-Reply-To: <m1elmu6srj.fsf_-_@frodo.biederman.org> from "Eric W. Biederman" at Nov 19, 2001 08:11:28 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The hard part is not linux booting linux but the passing of the
> firmware/BIOS tables from one kernel to the next.  Especially those
> that can only be obtained by a 16bit query.  It is my assumption that
> after the OS runs you cannot return to the firmware, it's state is
> hopelessly mangled.  That may not be totally true but it is fairly
> close to the truth. 

It is unless you control the firmware.  Our (Cobalt) firmware reserves a
region of memory which the primary (in-flash) kernel is not made aware of.
The in-flash kernel can do all the fun things a kernel can do, and then
return to firmware.
