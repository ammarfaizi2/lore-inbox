Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130185AbRBJAdO>; Fri, 9 Feb 2001 19:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130193AbRBJAdE>; Fri, 9 Feb 2001 19:33:04 -0500
Received: from hilbert.umkc.edu ([134.193.4.60]:64269 "HELO tesla.umkc.edu")
	by vger.kernel.org with SMTP id <S130185AbRBJAcw>;
	Fri, 9 Feb 2001 19:32:52 -0500
Message-ID: <3A848BFF.C7C0E258@cstp.umkc.edu>
Date: Fri, 09 Feb 2001 18:31:59 -0600
From: "David L. Nicol" <dnicol@cstp.umkc.edu>
Organization: University of Missouri - Kansas City   supercomputing infrastructure
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC: "Miller, Brendan" <Brendan.Miller@Dialogic.com>
Subject: Re: bidirectional named pipe?
In-Reply-To: <E14OxTz-0007yS-00@the-village.bc.nu> <3A81D5B4.9CBC9B0D@kasey.umkc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



According to the Understanding the Linux Kernel book I
plowed through yesterday afternoon the EXT2 file system
has a defined file type "socket," distinct from fifo.

How does one set up a named socket in a file system?  Is it
a legacy constant that has never been supported or what?





"David L. Nicol" wrote:
> 
> Alan Cox wrote:
> >
> > > I'm porting some software to Linux that requires use of a bidirectional,
> > > named pipe.  The architecture is as follows:  A server creates a named pipe
> >
> > Pipes are not bidirectional in Linux. We follow traditional non stream
> > behaviour
> >
> > > /dev/spx".  I experiemented with socket-based pipes under Linux, but I
> > > couldn't gain access to them by open()ing the name.  Is there help?  I
> >
> > AF_UNIX sockets are bidirectional but like all sockets use bind() and
> > connect().

> You could patch the file system code, I wonder how deep the changes would have
> to be, if you did it in terms of lots of fifos.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
                      David Nicol 816.235.1187 dnicol@cstp.umkc.edu
                          "I don't care how they do it in New York"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
