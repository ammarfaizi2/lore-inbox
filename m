Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbSAUNKF>; Mon, 21 Jan 2002 08:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285935AbSAUNIy>; Mon, 21 Jan 2002 08:08:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62731 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285850AbSAUNIu>;
	Mon, 21 Jan 2002 08:08:50 -0500
Message-ID: <3C4C12DF.36A99A66@mandrakesoft.com>
Date: Mon, 21 Jan 2002 08:08:47 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Gortmaker <p_gortmaker@yahoo.com>
CC: esr@thyrsus.com, Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Calling EISA experts
In-Reply-To: <20020117015456.A628@thyrsus.com> <20020117121723.B22171@suse.de> <3C46B718.26F52BD5@mandrakesoft.com> <20020117124849.F22171@suse.de> <20020117085056.B7299@thyrsus.com> <3C4C0056.4F50C3D6@yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Gortmaker wrote:
> 
> Eric S. Raymond wrote:
> 
> > Bingo.  I've got reliable /proc tests for ISAPNP, PCI, and MCA.  Previous
> > discussion indicates I can't get one for ISA classic.  An EISA test would,
> > as ever, allow me to cut the number of questions about ancient dead
> > hardware that users have to see.
> 
> Minimal approach: Register motherboard EISA ID (i.e. slot zero) ports in
> /proc/ioports.  Works on all kernel versions.  See $0.02 patch below.
> 
> This is probably the least intrusive way to get what you want.  It doesn't
> add Yet Another Proc File, and costs zero bloat to the 99.9% of us who
> have a better chance of meeting Aunt Tillie than an EISA box.
> 
> Possible alternative: Create something like /proc/bus/eisa/devices which
> lists the EISA ID (e.g. abc0123) found in each EISA slot.   This might
> have been worthwhile some 8 years ago, but now? ....

Actually, "lsescd" should list the EISA (and ISAPNP) configuration data,
which includes EISA id, etc.

	Jeff



-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
