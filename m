Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBOMMp>; Thu, 15 Feb 2001 07:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129106AbRBOMMf>; Thu, 15 Feb 2001 07:12:35 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:828 "EHLO twilight.cs.hut.fi")
	by vger.kernel.org with ESMTP id <S129093AbRBOMM3>;
	Thu, 15 Feb 2001 07:12:29 -0500
Date: Thu, 15 Feb 2001 14:11:55 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Aic7xxx troubles with 2.4.1ac6
Message-ID: <20010215141155.D1147@niksula.cs.hut.fi>
In-Reply-To: <20010208135606.F2223@viasys.com> <3A8296E3.FC1EE707@redhat.com> <20010208181601.H2223@viasys.com> <20010215125735.C1147@niksula.cs.hut.fi> <3A8BB89C.581BC524@redhat.com> <20010215132231.F1040@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010215132231.F1040@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Thu, Feb 15, 2001 at 01:22:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2001 at 01:22:31PM +0200, you [Ville Herva] claimed:
> On Thu, Feb 15, 2001 at 06:08:12AM -0500, you [Doug Ledford] claimed:
> > 
> > There was a new aic7xxx driver (version 5.2.3) that went into the 2.4.1ac
> > kernel series around 2.4.1-ac7.  I would be curious to know if it worked on
> > your machine properly.
> 
> Ok. Will try. 

Tried 2.4.1ac13 vanilla. Still a no-go:

SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is neing reset for host 0 channel 0
(scsi0:0:0:0) Synchronous at 40.0MBytes/s offset 31
SCSI host 0 abort (pid 0) timed out - trying harder
SCSI bus is being reset for host 0 channel 0
(scsi0:0:0:0) Synchronous at 40.0MBytes/s offset 31
scsi: aborting command due to timeout pid 0 scsi 0 channel 0 id 0 lun 0
Read (10) 00 00 00 00 00 00 00 02 00
SCSI SIGI 0x14 SEDADDR 0x77 SSTAT 0x0 SSTAT 0x2 SG_CACHEPTR 0x6 SSTAT2 0xC0 ST 0x0F0

(copied by hand, so please excuse the typos.)

Although 2.4.1ac13+Gibbs's aic7xxx seems to work perfectly, I still
wouldn't count out the possibility a hardware fault of some kind, since the
box already begun failing to find the boot record at 80MB/sec as well.


-- v --

v@iki.fi
