Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262335AbRERPKM>; Fri, 18 May 2001 11:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262339AbRERPKD>; Fri, 18 May 2001 11:10:03 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:13072 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262335AbRERPJr>;
	Fri, 18 May 2001 11:09:47 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: CML2 <linux-kernel@vger.kernel.org>
cc: kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up 
In-Reply-To: Your message of "Fri, 18 May 2001 10:53:53 -0400."
             <20010518105353.A13684@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 May 2001 01:09:41 +1000
Message-ID: <1694.990198581@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cc trimmed back to mailing lists only.

On Fri, 18 May 2001 10:53:53 -0400, 
"Eric S. Raymond" <esr@thyrsus.com> wrote:
>   (a) Back off the capability approach.  That is, accept that 
>       people doing configuration are going to explicitly and 
>       exhaustively specify low-level hardware.

No, you loose one of the nicer features of CML2.

>   (b) Add complexity to the ruleset.  Split SCSI into SCSI_MIDLEVEL and 
>       SCSI_DRIVERS capabilities, make sure SCSI_DRIVERS is implied
>       whenever a SCSI card is configured, etc.

As a specific case this needs doing anyway, to handle SCSI emulation
over IDE, irrespective of the board type.  It needs mid layer but no
SCSI driver and can be done on a PC right now.

As a general question, I prefer selecting machine type foo to mean just
that, you get the devices supported by foo.

>   (c) Decide not to support this case and document the fact in the
>       rulesfile.  If you're going put gunge on the VME bus that replaces
>       the SBC's on-board facilities, you can hand-hack your own configs.

In general this is the best option, if you create a non-standard
configuration for machine foo then it is your problem, not everybody
else's.

