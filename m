Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRA3AOa>; Mon, 29 Jan 2001 19:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130982AbRA3AOL>; Mon, 29 Jan 2001 19:14:11 -0500
Received: from smtp-server.maine.rr.com ([204.210.65.66]:46305 "HELO
	smtp-server.maine.rr.com") by vger.kernel.org with SMTP
	id <S129051AbRA3AOC>; Mon, 29 Jan 2001 19:14:02 -0500
Message-ID: <000a01c08a50$3176f430$b001a8c0@caesar>
From: "paradox3" <paradox3@maine.rr.com>
To: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Poor SCSI drive performance FIXED on SMP machine, 2.2.16
Date: Mon, 29 Jan 2001 19:04:19 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! I have added a terminator to the SCSI bus and also turned on TCQ and
now
I can write out 100 MB in 10 seconds (as opposed to several minutes)

Regards, Para-dox (paradox3@maine.rr.com)


----- Original Message -----
From: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>
To: "paradox3" <paradox3@maine.rr.com>
Sent: Sunday, January 28, 2001 8:56 PM
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16


> On Sun, 28 Jan 2001 19:58:04 -0500, paradox3 wrote:
>
> >I've attached the output in the kernel ring buffer as it initializes the
> >scsi drive. I haven't been
> >able to find IBM's website for DGHS09U to see if it self terminates.
Maybe
> >you
> >can tell.
>
> Yeah, I have the PDF manual for that one here too - I used to have one.
It's a Single ended
> (ie not LVD), fast, wide 7200rpm drive with a 68 pin connector. It has a
top speed of about
> 14MB/sec. Pretty good drive in its day. It's the 7200rpm drive of the same
generation as my
> DGVS09U - the manual I have is dated October 1997.
>
> From the manual...
>
> Enable Active Termination
>  Single Ended 50 and 68 pin models are available with on card SCSI Bus
Active Terminators.
> The Active Termination feature can be enabled by installing a jumper
between pins 13 and 14
> of the Front Option Jumper Block or connecting pins 9 and 10 of the
Auxiliary Connector on
> 68 SCSI pin models. SCA-2 80 pin has no termination.
>
> If you need more information about the drive, IBM are usually pretty good
at keeping it on
> their web site, http://www.storage.ibm.com should get you more.
>
> I'd guess you need to jumper pins 13+14 of the front jumper block *or*
pins 9+10 of the jumper
> block on the back that lies between the power connector and the 68 pin
cable connector. On
> the back connector pins 1+2 are the ones nearest the power connector. On
the front connector
> pin 1 is the lefthandmost pin when you look at it with the PCB downwards
and the front of the
> drive towards you.
>
> Since this looks like it's the only device you have attached to the
controller then you should also
> look in the BIOS setup (Ctrl-A at boot time) and find the section that
talks about controller
> termination. You can either set this to Automatic which usually works but
sometimes gets it
> wrong or you can set it to Low On/High ON which is correct if you have no
external devices
> and no devices attached to the internal 50 pin connector.
>
>
> Trevor Hemsley, Brighton, UK.
> Trevor-Hemsley@dial.pipex.com
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
