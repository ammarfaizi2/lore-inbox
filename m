Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSFXUuQ>; Mon, 24 Jun 2002 16:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSFXUuP>; Mon, 24 Jun 2002 16:50:15 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:11912 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315266AbSFXUuN>; Mon, 24 Jun 2002 16:50:13 -0400
Subject: Re: [Lse-tech] efficient copy_to_user and copy_from_user routines in Linux
 Kernel
To: "Niels Christiansen" <nc@ejna.ribald.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net, lse-tech-admin@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF500F7A2D.770AF176-ON85256BE2.00717D23@raleigh.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Mon, 24 Jun 2002 15:50:01 -0500
X-MIMETrack: Serialize by Router on D04NM108/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/24/2002 04:50:02 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Niels-
       Thanks for reminding me, the mmx results are inconclusive.  I will
be looking at
this when I come back from OLS in July.

Regards,
    Mala


   Mala Anand
   E-mail:manand@us.ibm.com
   Linux Technology Center - Performance
   Phone:838-8088; Tie-line:678-8088




                                                                                                                                               
                      "Niels Christiansen"                                                                                                     
                      <nc@ejna.ribald.com>             To:       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,                   
                      Sent by:                          <lse-tech@lists.sourceforge.net>                                                       
                      lse-tech-admin@lists.sour        cc:                                                                                     
                      ceforge.net                      Subject:  Re: [Lse-tech] efficient copy_to_user and copy_from_user routines in Linux    
                                                        Kernel                                                                                 
                                                                                                                                               
                      06/24/02 03:24 PM                                                                                                        
                                                                                                                                               
                                                                                                                                               



Mala,

As you may recall, I showed you results back in February with MMX registers
enabled.  I also gave you a simple patch to test activate the use of the
MMX
registers.  It would be interesting if you could run your test with the MMX
patch so we could see the difference.  In case you forgot the patch, it is
as simple as setting CONFIG_X86_USE_3DNOW on for Pentium III in
arch/i386/config.in.

Niels Christiansen

----- Original Message -----
From: "Mala Anand" <manand@us.ibm.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>;
<lse-tech@lists.sourceforge.net>
Sent: Monday, June 24, 2002 2:34 PM
Subject: [Lse-tech] efficient copy_to_user and copy_from_user routines in
Linux Kernel


> Here is a 2.5.19 patch that improves the performance of IA32 copy_to_user
> and copy_from_user routines used by :
>
> (1) tcpip protocol stack
> (2) file systems
>
> Badari Pulavarty has suggested using mmx registers instead of integer
> registers in the unrolled loop copy method.  We are both investigating
> the performance of the copy routines when the mmx registers are used.
>
> Regards,
>     Mala



-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
_______________________________________________
Lse-tech mailing list
Lse-tech@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/lse-tech



