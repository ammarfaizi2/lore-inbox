Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277082AbRJZBdh>; Thu, 25 Oct 2001 21:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277119AbRJZBdV>; Thu, 25 Oct 2001 21:33:21 -0400
Received: from genesis.westend.com ([212.117.67.2]:3838 "EHLO
	genesis.westend.com") by vger.kernel.org with ESMTP
	id <S277082AbRJZBdP>; Thu, 25 Oct 2001 21:33:15 -0400
Date: Fri, 26 Oct 2001 03:33:44 +0200
From: Christian Hammers <ch@westend.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "David S. Miller" <davem@redhat.com>, axboe@suse.de, harlan@artselect.com,
        linux-kernel@vger.kernel.org
Subject: Re: SCSI tape crashes (was Re: BUG() in asm/pci.h:142 with 2.4.13)
Message-ID: <20011026033344.B6483@westend.com>
In-Reply-To: <20011025131107.C4795@suse.de> <20011025192351.A9823@westend.com> <20011025193248.J4795@suse.de> <20011025.172541.102577469.davem@redhat.com> <20011025192648.A13819@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011025192648.A13819@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Thu, Oct 25, 2001 at 07:26:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Some addition: the kernel (at least the 2.4.11-pre6 worked well with the 
tape streamer before the day I replaced the external RAID chassis (broken
display) with a new one. My personal guess in this case is that the 
new RAID has a different firmware and maybe a bug that triggers the crash-
condition whenever a second device (here the scsi tape) tries to use the
bus, too.

Would this scenario fit into your idea of the bug?  

bye,

 -christian-

On Thu, Oct 25, 2001 at 07:26:48PM -0700, Jeff V. Merkey wrote:
> >    Ok, someone else is meddling with the scatterlist then. I'll take a 2nd
> >    look.
> > 
> > Can people try out this patch?  I believe this will fix the bug.
> > 
> > --- drivers/scsi/st.c.~1~	Sun Oct 21 02:47:53 2001
> > +++ drivers/scsi/st.c	Thu Oct 25 17:23:45 2001
> > @@ -3233,6 +3233,7 @@

-- 
Christian Hammers    WESTEND GmbH - Aachen und Dueren     Tel 0241/701333-0
ch@westend.com     Internet & Security for Professionals    Fax 0241/911879
           WESTEND ist CISCO Systems Partner - Premium Certified

