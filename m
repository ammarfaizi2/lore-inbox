Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLDX3T>; Mon, 4 Dec 2000 18:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130339AbQLDX3J>; Mon, 4 Dec 2000 18:29:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12807 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130397AbQLDX25>;
	Mon, 4 Dec 2000 18:28:57 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012042258.eB4Mw7w02090@flint.arm.linux.org.uk>
Subject: Re: aacraid for 2.4.0
To: ak@suse.de (Andi Kleen)
Date: Mon, 4 Dec 2000 22:58:06 +0000 (GMT)
Cc: Brian_Boerner@adaptec.com (Boerner Brian),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.redhat.com')
In-Reply-To: <20001204234938.A26074@gruyere.muc.suse.de> from "Andi Kleen" at Dec 04, 2000 11:49:38 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
> On Mon, Dec 04, 2000 at 05:31:04PM -0500, Boerner, Brian wrote:
> > EIP:    0010:[<c881c054>]

Note the value of EIP, and compare it with the structure size of
"struct module".

> > Code: 00 00 00 00 00 00 00 00 b8 00 00 00 83 ec 34 68 00 2c 82 c8 
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>...
> Now you just have to find out why you're jumping to the bogus pointer.
> It could e.g. be caused by a stack overwrite.

Naaa, its old modutils.  Upgrade to 2.3.21 and this problem will disappear.

(explaination: with old modutils, the kernel "forgets" to copy some bytes
into module space, which causes these zero'd bytes.  modutils 2.3.21 fixes
this.  In addition, the kernel bug has also been fixed in the current pre
patches, but this is not a recommendation to try the pre kernels out).
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
