Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135639AbRDSMKp>; Thu, 19 Apr 2001 08:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135641AbRDSMKf>; Thu, 19 Apr 2001 08:10:35 -0400
Received: from elin.scali.no ([195.139.250.10]:42761 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S135639AbRDSMK3>;
	Thu, 19 Apr 2001 08:10:29 -0400
Message-ID: <3ADED6CC.BA93CDCE@scali.no>
Date: Thu, 19 Apr 2001 07:15:08 -0500
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17-16enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Rico Tudor <rico@patrec.com>, linux-kernel@vger.kernel.org
Subject: Re: APIC errors ...
In-Reply-To: <E14q39x-00068C-00@the-village.bc.nu> <20010419022712.21723.qmail@pc7.prs.nunet.net> <20010419164303.A5416@metastasis.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Wed, Apr 18, 2001 at 09:27:12PM -0500, Rico Tudor wrote:
> 
>     Another problem area is ECC monitoring.  I'm still waiting for
>     info from ServerWorks, and so is Dan Hollis.  Alexander Stohr has
>     even submitted code to Jim Foster for approval, without evident
>     effect.  I have 18GB of RAM divided among five ServerWorks boxes,
>     so the matter is not academic.
> 
> Add environemt monitoring. One mf my play machines is a dell 2540,
> dual AC power, lots os fans and temperature sensing, I'd really like
> to be able to get this information from it (yeah, closed source Dell
> drivers are worth almost zero).
> 

This must be a Dell issue then, because I wrote a lm_sensors (http://www.netroedge.com/~lm78/) driver for the
ServerWorks OSB4 (SouthBridge) some time ago and they have merged it with the PIIX4 driver. lm_sensors 2.5.5 and above
should have support for the ServerWorks System Management Bus. I have been running lm_sensors 2.5.5 on several mobos
with ServerWorks chipset of all kinds (LE, HE, HE-SL) and most of them work with the PIIX4 driver (with OSB4 support).
The only one I've had problems with so far, is the Compaq DL360 which seem to have disabled the SMB on the OSB4 and
instead using another approach (proprietary). This could be the problem with the Dell machines too (2450, 2550, 1550).

Best regards
-- 
 Steffen Persvold                        Systems Engineer
 Email  : mailto:sp@scali.com            Scali AS (http://www.scali.com)
 Norway : Pho  : (+47) 2262 8950         Olaf Helsets vei 6
          Fax  : (+47) 2262 8951         N-0621 Oslo, Norway

 USA    : Pho  : (+1) 713 706 0544       10500 Richmond Ave, Suite 190
                                         Houston, Texas 77042, USA
