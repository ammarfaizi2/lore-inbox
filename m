Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130003AbQKKH56>; Sat, 11 Nov 2000 02:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130010AbQKKH5s>; Sat, 11 Nov 2000 02:57:48 -0500
Received: from 13dyn46.delft.casema.net ([212.64.76.46]:2830 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S130003AbQKKH5l>; Sat, 11 Nov 2000 02:57:41 -0500
Message-Id: <200011110757.IAA07593@cave.bitwizard.nl>
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
In-Reply-To: <8uhuno$bdp$1@cesium.transmeta.com> from "H. Peter Anvin" at "Nov
 10, 2000 03:01:12 pm"
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Sat, 11 Nov 2000 08:57:37 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <20001110142547.F16213@sendmail.com>
> By author:    Claus Assmann <sendmail+ca@sendmail.org>
> In newsgroup: linux.dev.kernel
> > 
> > Why does Linux report a LA of 10 if there are only two processes
> > running?
> > 
> 
> Load Average = runnable processes (R) + processes in disk wait (D).

Keep in mind that on some operating systems, sometimes processes
become STUCK in "short disk wait". That may mean that if you just
discard those processes (they won't do any useful work until you
reboot the system), you will see the load average one point higher
than what should be expected. 

This is almost always a bug somewhere. 

So, if you're not actually loading the machine with 12 processes doing
disk IO, and still seeing a load of 12, chances are that there are
processes stuck in the (D) state. That's a bug. Report the bug. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*       Common sense is the collection of                                *
******  prejudices acquired by age eighteen.   -- Albert Einstein ********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
