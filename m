Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266013AbRF2NTq>; Fri, 29 Jun 2001 09:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbRF2NTg>; Fri, 29 Jun 2001 09:19:36 -0400
Received: from mailhost.lineo.fr ([194.250.46.226]:35845 "EHLO
	mailhost.lineo.fr") by vger.kernel.org with ESMTP
	id <S266013AbRF2NT2>; Fri, 29 Jun 2001 09:19:28 -0400
Date: Fri, 29 Jun 2001 15:19:10 +0200
From: =?ISO-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Qlogic Fiber Channel
Message-ID: <20010629151910.C27847@pc8.lineo.fr>
In-Reply-To: <061801c10089$a5e89fd0$e1de11cc@csihq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <061801c10089$a5e89fd0$e1de11cc@csihq.com>; from mblack@csihq.com on Fri, Jun 29, 2001 at 12:52:53 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The qlogicfc driver is based on the chris loveland work.
You can find outdated information here :
	http://www.iol.unh.edu/consortiums/fc/linux/qlogic.html

>From my point of view, this driver is sadly broken. The fun part is that
the qlogic driver is certainly based on this one too (look at the code, the
drivers differs not so much). 
If you don't need IP support then keep using the qlogic driver which is far
better. I'm pretty sure that they have a working IP enhanced version but
for an unknow reason this one is not released. And without the IP-enhanced
firmware we can do nothing.

I've unsuccessfully tried to get information from qlogic and others a few
weeks ago. 
IMHO the qlogicfc driver should be removed from the kernel tree and perhaps
replaced by the last qlogic one. We then lost the IP support but this is a
broken support.

The qlogicfc driver blocks the kernel each time a FC event occured and is
know to failed under heavy load (not so heavy, under load IMHO).

Christophe

On Fri, 29 Jun 2001 12:52:53 Mike Black wrote:
> I have been running successfully with qla2x00src-4.15Beta.tgz for several
> months now over several kernel versions up to 2.4.5.
> When I tested 2.4.6-pre6 I decided to use the qlogicfc driver -- BAD
> MISTAKE!!!
> 
> #1 - My system had crashed (for a different reason) and when the raid5
> was
> resyncing and e2fsck happening at the same time the kernel locked with
> messages from qlogicfc.o:
> qlogicfc0: no handle slots, this should not happen.
> hostdata->queue  is 2a, inptr: 74
> I was able to repeat this several times so it's a consistent error.
> Waiting for the raid resync to finish did allow this complete -- but now
> when I come in the next morning the console is locked up and no network
> access either.  So I reset it.  Checked the logs and here it is again:
> Jun 29 03:39:21 yeti kernel: qlogicfc0 : no handle slots, this should not
> happen.
> Jun 29 03:39:21 yeti kernel: hostdata->queued is 36, in_ptr: 13
> This was during a tape backup.
> 
> So I'm switching back to qla2x00src-4.15Beta.tgz -- which does the resync
> and e2fsck just fine together BTW.
> Jun 29 06:22:47 yeti kernel: qla2x00: detect() found an HBA
> Jun 29 06:22:47 yeti kernel: qla2x00: VID=1077 DID=2100 SSVID=0 SSDID=0
> 
> Only problem is I don't see this package on qlogic's website anymore and
> their "beta" directory is empty now.  I'm waiting to see what their tech
> support says.
> 
> ________________________________________
> Michael D. Black   Principal Engineer
> mblack@csihq.com  321-676-2923,x203
> http://www.csihq.com  Computer Science Innovations
> http://www.csihq.com/~mike  My home page
> FAX 321-676-2355
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com
