Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129663AbRB0RTu>; Tue, 27 Feb 2001 12:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRB0RTk>; Tue, 27 Feb 2001 12:19:40 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:32506 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S129663AbRB0RTf>; Tue, 27 Feb 2001 12:19:35 -0500
To: Khalid Aziz <khalid@fc.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <54u25g3yb9.fsf_-_@intech19.enhanced.com> <3A9BC2A9.F5EE8554@fc.hp.com>
From: Camm Maguire <camm@enhanced.com>
Date: 27 Feb 2001 12:19:25 -0500
In-Reply-To: Khalid Aziz's message of "Tue, 27 Feb 2001 10:07:21 -0500"
Message-ID: <544rxg2gde.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, and thanks so much for your helpful reply!

Khalid Aziz <khalid@fc.hp.com> writes:

> Camm Maguire wrote:
> > 
> > The Conner gives the problem:
> > 
> > Feb 27 06:23:16 intech9 kernel: st0: Error with sense data: [valid=0] Info fld=0x0, Current st09:00: sns = 70  5
> > Feb 27 06:23:16 intech9 kernel: ASC=20 ASCQ= 0
> > Feb 27 06:23:16 intech9 kernel: Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00
> > 
> > and occaisional 'gunzip: unexpected end of file' errors on verifying
> > the tape.
> > 
> > Take care,
> > 
> > --
> > Camm Maguire                                            camm@enhanced.com
> 
> ASC/ASCQ of 0x20/0x00 means "Invalid command operation code". So the
> drive is rejecting a command sent to it by the driver. If the other
> drive that is working is identical to seemingly non-working one, maybe
> this drive is going bad. 
> 

Thanks for the error identification.  The other drive is of a
*different* model.  This drive showed this behavior from the day I
bought it.  The drive could be going bad, but I doubt it.  Is it
possible that this manufacturer (Conner) has some peculiar
implementation of the spec?  I recall reading on this list sometime
back of similar workarounds to unusual drives.


> st driver prints the SCSI command that may have caused this error only
> when compiled with debug turned on. Maybe st driver should always print
> the command that results in a check condition as long as the command is
> not a Test Unit Ready or Mode Sense. 
>  

Can I turn on debug mode in runtime, or do I need to recompile
ide-scsi? 

Take care,


> ====================================================================
> Khalid Aziz                             Linux Development Laboratory
> (970)898-9214                                        Hewlett-Packard
> khalid@fc.hp.com                                    Fort Collins, CO
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
