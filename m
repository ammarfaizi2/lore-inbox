Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267278AbUHDG1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUHDG1R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 02:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267274AbUHDG1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 02:27:17 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:38626
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S267278AbUHDG1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 02:27:11 -0400
Message-ID: <411081BD.6030706@bio.ifi.lmu.de>
Date: Wed, 04 Aug 2004 08:27:09 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: L A Walsh <lkml@tlinx.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS-mounted, read-only /dev unusable in 2.6
References: <410F481C.9090408@bio.ifi.lmu.de> <64bf.410f9d6f.62af@altium.nl> <410FA44F.1020804@bio.ifi.lmu.de> <410FCB3A.9000401@tlinx.org>
In-Reply-To: <410FCB3A.9000401@tlinx.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

L A Walsh wrote:
> Maybe I'm missing something, but in the 2.6 series, wasn't the ability
> to mount subdirectories with different options, also, added?  Would
> it be possible to export and mount /dev with rw options to a specific
> client?

Yes, that's an option. But all this needs to be done in the init script,
since with nfsroot I only get /. So mounting /dev rw from the server is
similar to figuring out which client-specific /dev should be mounted.
But in this init process things can fail and I want to see those messages.
If I fail to mount the server /dev rw for any reason, I won't see the
error message :-(

> 
> Or, more radical, if the roots of the clients end up being mounted RW
> eventually anyway, why not specify 'rw' in the lilo option?  It's not
> like it is a local filesystem that may be corrupt where one should
> boot from it RO until it is checked...

No, the real / is exported ro from the server and stays mounted ro on
the clients. Only the client specific /dev, /var and /etc are mounted
rw...

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
