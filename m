Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130448AbQKGXER>; Tue, 7 Nov 2000 18:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130449AbQKGXEH>; Tue, 7 Nov 2000 18:04:07 -0500
Received: from m11.boston.juno.com ([63.211.172.74]:60585 "EHLO
	m11.boston.juno.com") by vger.kernel.org with ESMTP
	id <S130448AbQKGXD6>; Tue, 7 Nov 2000 18:03:58 -0500
To: alan@lxorguk.ukuu.org.uk
Cc: x_coder@hotmail.com, andre@linux-ide.org, linux-kernel@vger.kernel.org
Date: Sat, 4 Nov 2000 19:04:08 -0500
Subject: Re: Pentium 4 and 2.4/2.5
Message-ID: <20001104.190410.-351455.2.fdavis112@juno.com>
X-Mailer: Juno 4.0.5
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Juno-Line-Breaks: 0-5,8-12,14-28
X-Juno-Att: 0
X-Juno-RefParts: 0
From: Frank Davis <fdavis112@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
  As for 'rep nop', couldn't we add in the code, as an example:  
#ifdef Pentium_4
rep nop
#endif

  As for the 2.2.18 patch for correctly determining 2GHz and above, can
it be easily  merged into the 2.4.x kernel, and if so, what's the maximum
clock speed that can be detected?

Regards,
-Frank

On Tue, 7 Nov 2000 21:48:40 +0000 (GMT) Alan Cox
<alan@lxorguk.ukuu.org.uk> writes:
> > are you saying that rep;nop is not needed in the spinlocks? 
> (because they
> > are for P4)
> 
> rep;nop is a magic instruction on the PIV and possibly some PIII 
> series CPUs
> [not sure]. As far as I can make out it naps momentarily or until 
> bus
> activity thus saving power on spinlocks.
> 
> The problem is 'rep nop' is not defined on other cpus so we can only 
> really use
> it on the PIII/PIV kernel builds
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
