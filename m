Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129814AbQKPX0e>; Thu, 16 Nov 2000 18:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130073AbQKPX0Z>; Thu, 16 Nov 2000 18:26:25 -0500
Received: from p3EE3C857.dip.t-dialin.net ([62.227.200.87]:15883 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129814AbQKPX0S>; Thu, 16 Nov 2000 18:26:18 -0500
Date: Thu, 16 Nov 2000 23:56:15 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
Message-ID: <20001116235615.B20283@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu> <20001116150704.A883@emma1.emma.line.org> <20001116171618.A25545@athlon.random> <20001116115249.A8115@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001116115249.A8115@wirex.com>; from jesse@wirex.com on Thu, Nov 16, 2000 at 11:52:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, jesse wrote:

> But the problem is because you can call chroot when you're already chrooted.

It's a non-problem. chroot()ing again may also be used to de-escalate
privileges, and if you want to prevent breaking out of a chroot, drop
root privileges, since chroot is a privileged call. And DO USE setuid,
not seteuid or something (otherwise the saved set-uid will bite you).

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
