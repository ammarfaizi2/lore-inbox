Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131429AbRCPWts>; Fri, 16 Mar 2001 17:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131426AbRCPWti>; Fri, 16 Mar 2001 17:49:38 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:34933 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131409AbRCPWtc>; Fri, 16 Mar 2001 17:49:32 -0500
Message-ID: <3AB2998F.EC58C3E5@redhat.com>
Date: Fri, 16 Mar 2001 17:54:07 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: scsi_scan problem.
In-Reply-To: <3AB028BE.E8940EE6@redhat.com> <3AB29636.64C90827@neuronet.pitt.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael E. Herrera" wrote:
> 
> I applied the first hunk to version 2.4.3-pre4, as by email with Doug.
> The output for the scsi devices follows and is identical with and
> without the patch.

Thank you Rafael.  This is what I suspected.  I'm not sure when we starting
considering devices with a peripheral qualifier of 1 as being valid, but I
suspect it happened when the scsi_scan.c code was separated out of scsi.c.  In
any case, I'm pretty positive that it is the wrong thing to do.  This report
at least alleviates one of my fears about broken device possibilities and
starts to confirm my position.

> Maybe someone can explain the meaning of the illegal
> requests at the end. Nevertheless, I can use the drive fine.

As to the illegal request messages, I'm not sure what those are about ;-)

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
