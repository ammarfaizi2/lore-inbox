Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUCVVHl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUCVVHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:07:40 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:28369 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262101AbUCVVHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:07:39 -0500
Date: Mon, 22 Mar 2004 16:02:52 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PnPBIOS: Unknown tag '0x82'
Message-ID: <20040322160252.GA6414@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Meelis Roos <mroos@linux.ee>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.44.0403221937330.18189-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0403221937330.18189-100000@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 07:47:21PM +0200, Meelis Roos wrote:
> Since the beginning of its existence, the pnpbios driver talks about
> unknown tag '0x82' on one of my computers. The computer has Intel
> D815EEA2 mainboard, BIOS has been updated quite recently. I added the
> tag dump to printout and here it is:
> 
> PnPBIOS: Unknown tag '0x82', length '18': 82 12 00 49 6e 74 65 6c 20 46 69 72 6d 77 61 72 65 20
> 
> This 0x82 0x12 0x00 and then 'Intel Firmware'.
> 
> Anything to worry about? Are the next tags still correctly parsed? The
> full dmesg is now
> 
> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0xc00f2480
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x1d2a, dseg 0xf0000
> pnp: 00:09: ioport range 0x4d0-0x4d1 has been reserved
> pnp: 00:09: ioport range 0xcf8-0xcff could not be reserved
> PnPBIOS: Unknown tag '0x82', length '18': 82 12 00 49 6e 74 65 6c 20 46 69 72 6d 77 61 72 65 20 .
> pnp: 00:0b: ioport range 0x800-0x87f has been reserved
> PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver
> 
> -- 
> Meelis Roos (mroos@linux.ee)

In this case it should be harmless.  Typically when one tag is
corrupted (or incorrectly interpreted) it will also complain
about the following tag because of size checks.  Where did the
unknown tag occur?  Perhaps in pnpbios_parse_resource_option_data?

Thanks,
Adam
 
