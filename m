Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbRBHQQc>; Thu, 8 Feb 2001 11:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129253AbRBHQQW>; Thu, 8 Feb 2001 11:16:22 -0500
Received: from linux2.viasys.com ([194.100.28.129]:9737 "HELO mail.viasys.com")
	by vger.kernel.org with SMTP id <S129130AbRBHQQG>;
	Thu, 8 Feb 2001 11:16:06 -0500
Date: Thu, 8 Feb 2001 18:16:01 +0200
From: Ville Herva <vherva@viasys.com>
To: Doug Ledford <dledford@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jarkko Sireeni <jarkko.sireeni@viasys.com>,
        Tapani Parmanen <tpa@viasys.com>, Markus Kemppinen <mkp@viasys.com>
Subject: Re: Aic7xxx troubles with 2.4.1ac6
Message-ID: <20010208181601.H2223@viasys.com>
In-Reply-To: <20010208135606.F2223@viasys.com> <3A8296E3.FC1EE707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <3A8296E3.FC1EE707@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 07:53:55AM -0500, you [Doug Ledford] claimed:
> Ville Herva wrote:
> > 
> > It looks like ac6 (which I believe includes the patch you posted) is
> > still a no-go with 7892. The boot halts and it just prints this once a
> > second:
> > 
> > (SCSI0:0:3:1) Synchronous at 160 Mbyte/sec offset 31
> > (SCSI0:0:3:1) CRC error during data in phase
> > (SCSI0:0:3:1)   CRC error in intermediate CRC packet
> 
> Check your cables, especially the connector on the card and the drive.  Look
> for any possible bent pins.  The message you are seeing is *usually*, but not
> always, a legitimate data corruption issue.  It doesn't show up under the
> 5.2.1 driver because it limits your Quantum drive to 80MByte/s and that
> particular speed doesn't include CRC checking.  On this driver you have to be
> running at 160MByte/s before CRC checking is enabled.

I checked the cables. I think HP didn't supply proper 160 MB/S capable
cables (aren't those the ones with wattlings?). When I forced the drive to
80MB/s from bios, not only did aic7xxx/ac6 work like charm, but the BIOS
also found the "missing" MBR. Stupid problem ;).

Thanks for your help!


--
Ville Herva            vherva@viasys.com             +358-50-5164500
Viasys Oy              Hannuntie 6  FIN-02360 Espoo  +358-9-2313-2160
PGP key available: http://www.iki.fi/v/pgp.html  fax +358-9-2313-2250
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
