Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130201AbRB1O4K>; Wed, 28 Feb 2001 09:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130202AbRB1Oz7>; Wed, 28 Feb 2001 09:55:59 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:3005 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130201AbRB1Ozp>; Wed, 28 Feb 2001 09:55:45 -0500
Message-ID: <3A9D11E5.919104C3@redhat.com>
Date: Wed, 28 Feb 2001 09:57:41 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Igor Mozetic <igor.mozetic@uni-mb.si>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2 + aic7xxx still broken
In-Reply-To: <15004.63506.871707.827656@ravan.camtp.uni-mb.si>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Mozetic wrote:
> 
> I'm still unable to boot any 2.4.x kernel on this box:
> Intel C440GX+, on-board Adaptec AIC-7896/7, 2GB RAM.
> 
> 2.4.2 + stock aic7xxx:
> ----------------------
> ...
> SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
> SCSI bus is being reset for host 0 channel 0
> ... ad infinitum
> 
> 2.4.2 + http://people.FreeBSD.org/~gibbs/linux/ aic7xxx-6.1.4-2.4.2-pre4:
> -------------------------------------------------------------------------
> ...
> aic7xxx - abort returns 8194
> scsi1:0:0:0 Attempting to queue an ABORT message
> scsi1:0:0:0 Command already completed
> scsi1:0:0:0 Attempting to queue a TARGET RESET message
> scsi1:0:0:0 is not an active device
> ... ad infinitum
> 
> 2.2.[17,18] stock driver works fine.
> I can provide more info if needed. Any help appreciated.

Sounds like an IRQ routing problem.  Have you tried a UP kernel with IO-APIC
on UP support disabled or an SMP kernel both with and without the noapic
options to see if they make a difference?

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
