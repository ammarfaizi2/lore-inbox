Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130417AbRA2MzP>; Mon, 29 Jan 2001 07:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130919AbRA2MzF>; Mon, 29 Jan 2001 07:55:05 -0500
Received: from kullstam.ne.mediaone.net ([66.30.138.210]:13208 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S130417AbRA2My5>; Mon, 29 Jan 2001 07:54:57 -0500
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16
In-Reply-To: <F65Jqj0CYixMwInhdAH00002ef1@hotmail.com>
	<001601c089b0$b1ec80d0$b001a8c0@caesar>
Organization: none
Date: 29 Jan 2001 07:58:13 -0500
In-Reply-To: <001601c089b0$b1ec80d0$b001a8c0@caesar>
Message-ID: <m2bssqikgq.fsf@euler.axel.nom>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"paradox3" <paradox3@maine.rr.com> writes:

> Here is the output from dmesg. How do I tell if it is improperly
> terminated?

you never gave the model of the hard drive (or if you did, i didn't
see it), but you did say a 10k rpm ibm.  i am going to assume it is
u2w/lvd capable.  no lvd hard drive has termination built in.  you
must use a seperate termination device at the end of the ribbon.  or
you can use a terminating cable.  since your controller is a
single-ended device, get a single-ended, wide, active terminator and
plug it into the end of the ribbon.  put the hard drive in the middle
somewhere.

see <URL:http://www.scsifaq.org/> for more information.

> Thanks, Para-dox (paradox3@maine.rr.com)
> 
> 
> 
> 
> ----- Original Message -----
> From: "Michael Brown" <flight666@hotmail.com>
> To: <paradox3@maine.rr.com>
> Sent: Sunday, January 28, 2001 11:12 PM
> Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16
> 
> 
> > Your problem appears to be improper SCSI termination.
> >
> > You need to either
> >   1) make sure your SCSI drive has termination enabled
> > or
> >   2) move your SCSI drive to the middle connector and put a terminator on
> > the last connector
> >
> > Check your syslog and post to l-k the part where it detects your drives.
> > I'll bet the adapter is throttling back quite dramatically in the presence
> > of improper termination.
> >
> > --
> > Michael Brown
> >
> > _________________________________________________________________
> > Get your FREE download of MSN Explorer at http://explorer.msn.com
> >
> >
> 

-- 
J o h a n  K u l l s t a m
[kullstam@ne.mediaone.net]
Don't Fear the Penguin!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
