Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130601AbQKQMEY>; Fri, 17 Nov 2000 07:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132055AbQKQMEO>; Fri, 17 Nov 2000 07:04:14 -0500
Received: from p3EE3CBE2.dip.t-dialin.net ([62.227.203.226]:55301 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S130601AbQKQMED>; Fri, 17 Nov 2000 07:04:03 -0500
Date: Fri, 17 Nov 2000 12:34:01 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
Message-ID: <20001117123401.B24565@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu> <20001116171618.A25545@athlon.random> <20001116115249.A8115@wirex.com> <20001117003000.B2918@wire.cadcamlab.org> <8v2js0$qpr$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8v2js0$qpr$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, Nov 16, 2000 at 22:40:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, H. Peter Anvin wrote:

> BUG: you *MUST* chdir() into the chroot jail before it does you any
> good at all!
> 
> I usually recommend:

  #include <sysexits.h>
  /* for EX_NOUSER */

> mkdir("foo");
> chdir("foo");
> chroot(".");

add this:

  /* DO REPLACE 500 BY AN EXISTING USER ID */
  /* DO NOT REPLACE IT BY 0! */
  /* DO NOT USE OTHER FUNCTIONS THAN setuid() */
  if(setuid(500)) { _exit(EX_NOUSER); }

(For the records and search engines, most people should know that, but
to have it all in one mail.)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
