Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135537AbRDXLFC>; Tue, 24 Apr 2001 07:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135541AbRDXLEw>; Tue, 24 Apr 2001 07:04:52 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:4065 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S135537AbRDXLEp>;
	Tue, 24 Apr 2001 07:04:45 -0400
Message-ID: <3AE55DD0.D4C334D7@mandrakesoft.com>
Date: Tue, 24 Apr 2001 07:04:48 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Walter <srwalter@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: serial driver not properly detecting modem
In-Reply-To: <20010423223847.A3945@hapablap.dyn.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Walter wrote:
> 
> It would seem that I have a modem (hardware based, not winmodem) of
> PCI_CLASS_COMMUNICATION_OTHER.  This, unfortunately, prevents it from
> being automagically detected by the serial driver, which only looks for
> devices of 
> 
> I've fixed this here merely by adding an entry to the PCI table of
> serial.c for PCI_CLASS_COMMUNICATION_OTHER.  Is this the best way to fix
> this?  Is there some reason that this shouldn't be done in general?  If
> not, I'd like to see it fix in the kernel proper.

That won't work for a general rule, since winmodems list themselves as
'OTHER' too.  Just add your PCI id above the
PCI_CLASS_COMMUNICATION_SERIAL.

Make sure you cc me and tytso@mit.edu on such a patch...

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
