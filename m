Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265479AbRFVRe3>; Fri, 22 Jun 2001 13:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbRFVReL>; Fri, 22 Jun 2001 13:34:11 -0400
Received: from james.kalifornia.com ([208.179.59.2]:32568 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S265478AbRFVReB>; Fri, 22 Jun 2001 13:34:01 -0400
Message-ID: <3B338174.1070507@blue-labs.org>
Date: Fri, 22 Jun 2001 10:33:40 -0700
From: David Ford <david@blue-labs.org>
Organization: Blue Labs
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-pre1 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [bug] OOPS/stunted boot, aic7xxx, 2.4.x
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'lo

I have a client machine that I can't get 2.4 to boot on.  It is an SMP 
motherboard with one CPU  , dual port aic7896/97 ultra2 onboard.

I'm slowing going backwards from 2.4.6-pre5 and am currently compiling 
2.4.3.  With the later kernels, the machine simply hangs, flat out does 
nothing instead of initializing the aic driver.  With the earlier 
kernels I get the below messages.  BTW, why the heck is the linux kernel 
relying on Berkely DB?  I find it rather bothersome that I have to go 
fetch and compile a userland library just to compile the aic driver.

More details to follow I'm sure.

David

--------


scsi:0:0:0:0 Attempting to queue an ABORT message
..Command already completed
aic7xxx_abort returns 8194
..Attempting to queue an ABORT message
..Device is active, asserting aTN
Recovery code sleeping
Recovery code awake
..Timer expired
..returns 8195
..attepting to queue a TARET RESET message
..returns 8195
..recovery SCB completes
..attempting to queue an abort
ahc_intr : HOST_MSG_LOOP bad phase 0x0
..command aborted from QINFIFO
..returns 8194
scsi: device set offline - not ready or command retry failed after bus 
reset: host  0 channel 0  id 0 lun 0

(partially repeats for each id, 1-15, on both  ports)


