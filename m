Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbUJZVO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbUJZVO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUJZVO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:14:56 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:50438 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261473AbUJZVOl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:14:41 -0400
Message-ID: <417EBE80.3030505@tmr.com>
Date: Tue, 26 Oct 2004 17:15:44 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Paulo Marques <pmarques@grupopie.com>,
       "Nico Augustijn." <kernel@janestarz.com>, hvr@gnu.org,
       clemens@endorphin.org, linux-kernel@vger.kernel.org
Subject: Re: Cryptoloop patch for builtin default passphrase 
References: <200410251754.i9PHsVrI018284@turing-police.cc.vt.edu> <200410251905.i9PJ5Rrj013717@turing-police.cc.vt.edu>
In-Reply-To: <200410251905.i9PJ5Rrj013717@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 25 Oct 2004 19:23:35 BST, Paulo Marques said:
> 
> 
>>(why would you need confidential information to boot in the first place?)
> 
> 
> The problem is not that the info in the NVRAM is "confidential",
> but that most of it is "configuration".
> 
> Really sucks if you recable your SCSI controllers, the default boot disk
> changes from controller 4, device 5, to controller 2, device 3 - and you
> have to go and re-cable the OLD way, find the rescue CD, and fix /etc/fstab
> so that you can boot in the same config that you installed the software?
> 
> Either that, or forever lose the use of "default boot device", and
> have to specify it on every single boot if you want the software to work.
> That *really* sucks if it's a rack-mount in a colo, you need to get physical
> access to reboot....
> 
> 
>>No it is not. You would just type in again *if* the contents of nvram 
>>got lost which shouldn't happen in the first place (or at least happen 
>>rarely).
> 
> 
> So you change IRQ9 from level to edge trigger, or change "default boot order"
> from "floppy, cd, hard drive" to "floppy, cd, hard drive, network", and
> suddenly your software evaporates?
> 
> That certainly violates the Principle of Least Surprise, and why I asked
> if it was an intended effect.

It depends on the intent of the encryption. If the purpose is the 
protect the data, then this is acceptable. In some cases it is more 
important to protect the data than to preserve them.

More to the point, I thought there was a small section of nvram reserved 
to local system use, which the BIOS should not change. The appropriate 
manual is 100 miles away, I have no time to google. Beside which someone 
will pop up with the answer before I could look ;-)

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
