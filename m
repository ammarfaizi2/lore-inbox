Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbRCLQxV>; Mon, 12 Mar 2001 11:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130509AbRCLQxH>; Mon, 12 Mar 2001 11:53:07 -0500
Received: from atlrel2.hp.com ([156.153.255.202]:14579 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S130502AbRCLQwT>;
	Mon, 12 Mar 2001 11:52:19 -0500
Message-ID: <3AACFEC7.5A48F607@fc.hp.com>
Date: Mon, 12 Mar 2001 09:52:23 -0700
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Camm Maguire <camm@enhanced.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <54u25g3yb9.fsf_-_@intech19.enhanced.com> <3A9BC2A9.F5EE8554@fc.hp.com> <544rxg2gde.fsf@intech19.enhanced.com> <3A9BC8ED.698DCA2C@fc.hp.com> <54vgpvq4y1.fsf@intech19.enhanced.com> <3A9BEF68.72EEF0E8@fc.hp.com> <54snkpyyug.fsf@intech19.enhanced.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

11,3 is "Multiple read errors". You can find all of the ASC and ASCQ
listed in any SCSI spec document. You can find the SCSI-2 specs at
<ftp://ftp.t10.org/t10/drafts/s2/s2-r10l.pdf>.

--
Khalid

Camm Maguire wrote:
> 
> Thank you again for your help.  While I do seem to get more errors
> with the ide-tape driver, I am also seeing some problems on further
> examination which are common to both ide-tape and st over ide-scsi, so
> perhaps I have a bad drive or tape.
> 
> When trying to mt eom, for example, I get
> 
> =============================================================================
> st0: Error: 28000000, cmd: 5 0 0 0 0 0 Len: 16
> [valid=0] Info fld=0x0, Current st09:00: sns = 70  5
> ASC=20 ASCQ= 0
> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00
> st0: Can't read block limits.
> st0: Mode sense. Length 11, medium b6, WBS 10, BLL 8
> st0: Density 45, tape length: 0, drv buffer: 1
> st0: Block size: 512, buffer size: 32768 (64 blocks).
> st0: Retensioning tape.
> st0: Error: 28000000, cmd: 5 0 0 0 0 0 Len: 16
> [valid=0] Info fld=0x0, Current st09:00: sns = 70  5
> ASC=20 ASCQ= 0
> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00
> st0: Can't read block limits.
> st0: Mode sense. Length 11, medium b6, WBS 10, BLL 8
> st0: Density 45, tape length: 0, drv buffer: 1
> st0: Block size: 512, buffer size: 32768 (64 blocks).
> st0: Spacing tape forward over 16383 filemarks.
> st0: Spacing to end of recorded medium.
> st0: Error: 28000000, cmd: 11 3 0 0 0 0 Len: 16
> Info fld=0x3feb, Deferred st09:00: sns = f1  3
> ASC=11 ASCQ= 3
> Raw sense data:0xf1 0x00 0x03 0x00 0x00 0x3f 0xeb 0x0a 0x00 0x00 0x00 0x00 0x11 0x03 0x00 0x00
> st0: Error: 28000000, cmd: 5 0 0 0 0 0 Len: 16
> [valid=0] Info fld=0x0, Current st09:00: sns = 70  5
> ASC=20 ASCQ= 0
> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00
> st0: Can't read block limits.
> st0: Mode sense. Length 11, medium b6, WBS 10, BLL 8
> st0: Density 45, tape length: 0, drv buffer: 1
> st0: Block size: 512, buffer size: 32768 (64 blocks).
> st0: Rewinding tape.
> =============================================================================
> 
> What is the 11,3?  Where can I find these codes listed?  Why is the
> drive having trouble finding the end of the tape?  I'll be testing
> more tapes soon, but this definitely happens with at least several.
> The mt command returned to the prompt with 'Input/ouput error'.
> 
> Many Thanks again,
> 

-- 
====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
