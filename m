Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293675AbSCKKid>; Mon, 11 Mar 2002 05:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293676AbSCKKiY>; Mon, 11 Mar 2002 05:38:24 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:3067 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S293675AbSCKKiL>; Mon, 11 Mar 2002 05:38:11 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200203101643.RAA02302@harpo.it.uu.se> 
In-Reply-To: <200203101643.RAA02302@harpo.it.uu.se> 
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6 PPP deflate breakage on UP 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Mar 2002 10:37:58 +0000
Message-ID: <27817.1015843078@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mikpe@csd.uu.se said:
>  The patch below adds an #include <linux/interrupt.h> which works
> around this. I'm not sure about <linux/smp_lock.h>: it really doesn't
> look appropriate for the locking primitives being used in
> ppp_deflate.c. 

You're right - it can go.

In fact, I think the whole delayed-vfree thing can be dropped in davej's
tree and fed to Linus when the PPP locking changes are.

--
dwmw2


