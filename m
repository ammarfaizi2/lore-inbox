Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbRFQRDx>; Sun, 17 Jun 2001 13:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261881AbRFQRDn>; Sun, 17 Jun 2001 13:03:43 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:8462 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261866AbRFQRDa>; Sun, 17 Jun 2001 13:03:30 -0400
Message-ID: <3B2CE2CE.7020705@zytor.com>
Date: Sun, 17 Jun 2001 10:03:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Roberto Di Cosmo <roberto@dicosmo.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        Roberto Di Cosmo <Roberto.Di-Cosmo@pps.jussieu.fr>,
        linux-kernel@vger.kernel.org, demolinux@demolinux.org
Subject: Re: [isocompr PATCH]: first comparison with HPA's zisofs
In-Reply-To: <20010611225944.B959@bug.ucw.cz>	<E159r4y-0001bR-00@the-village.bc.nu> <15148.49603.742951.360288@beryllium.pps.jussieu.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Di Cosmo wrote:

>
> 
> I have only the following (minor) criticisms 
> 
> - the transparent compression scheme does not rely on a special
>   filename extension (it was .gZ in isocompr): a file foo gets
>   compressed to a file foo, and the only way to see if foo is
>   compressed or not is to read the header. This has pros and cons...
>   and I wonder what the reasons of this choice are.
> 


It caused ALL kinds of nastiness; the chosen solution was vastly simpler 
on a whole bunch of axes.


> - the tools allow to compress/decompress only a whole directory tree,
>   while it should be possible to act on a single file also: in DemoLinux
>   not all files are compressed (some must be readable under (hem...) other
>   less interesting OSs for example ;-)) and the distinction is not on
>   a per-directory basis.
>   [easy to fix, see patch at the end of this message: I did this to
>   be able to try zisofs with DemoLinux]
> 


You can do this by having the compressed and uncompressed files in 
different directory trees and merge them using mkisofs.  I personally 
think that's a cleaner solution, even if your suggestion might make 
sense anyway.  Your patch, though, is too ugly to live.


> - it seems to me that this was written with 2.4.x in mind, and I did not
>   find a version for 2.2.x kernels :-(
> 
> Now I wonder, if zisofs is going to be included into 2.5 (I would strongly
> vote in favour!), would it be worthwhile to include a compatibility mode
> to read the isocompr blocksized format too?
> 


No.  isocompr was misdesigned, and such a compatibility mode would 
needlessly complicate everything.

	-hpa



