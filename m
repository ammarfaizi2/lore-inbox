Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132559AbQKSQdH>; Sun, 19 Nov 2000 11:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132556AbQKSQcr>; Sun, 19 Nov 2000 11:32:47 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:10024 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S132626AbQKSQcn>; Sun, 19 Nov 2000 11:32:43 -0500
Message-ID: <3A17F994.99EB8F8F@linux.com>
Date: Sun, 19 Nov 2000 08:02:28 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <20001117013157.A21329@almesberger.net> <slrn91b42n.fs.kraxel@bogomips.masq.in-berlin.de> <20001118141426.B23033@almesberger.net> <slrn91f3hr.jt.kraxel@bogomips.masq.in-berlin.de> <3A17AF88.F1319C2C@linux.com> <slrn91fjfh.dta.kraxel@bogomips.masq.in-berlin.de>
Content-Type: multipart/mixed;
 boundary="------------523D952EC95F597556D7534F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------523D952EC95F597556D7534F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Why not?  /me has nearly everything compiled as modules.

Some people have extensive sh, awk and sed scripts to manage their systems, some
have compiled programs.


> > There is an introduced security weakness by using kernels.
>
> ???  Guess you mean "by using modules"?  Which weakness?  Other than
> bugs?  I don't see bugs like the recent modprobe oops as major problem.
> They happen (everythere), they get fixed.

If your server has a kernel that doesn't support modules, then a trojan hiding
module can't be used.  Modules are easily tampered with and you no more the wise.



> > So..what is the point in making it modular?
>
> It's much more flexible.
>
> You can reconfigure/update the driver without recompiling the kernel
> and without rebooting.  If the driver needs some tweaks to make it
> work with your hardware you can update /etc/modules.conf and reload
> the modules with the new options.  If you have found a working
> configuration, you can simply leave it as is.

Modules are fantastic for workstations, testbeds, machines that change a lot.
Servers are normally a static configuration.  I won't ship a blackbox device to a
customer that allows them to twiddle with things, their curiosity becomes a
maintenance hassle.  I have a product in the lab that uses bttv and I'd really
love to be able to compile it into the kernel.


>  * rmmod ide-cd; modprobe ide-scsi; modprobe sr_mod (for burning CD's)
>  * /etc/rc.d/init.d/network stop; rmmod de4x5; modprobe tulip;
>    /etc/rc.d/init.d/network start (tulip manages it to drive the card
>    full-duplex, de4x5 doesn't).

Tulip works dandy for me, I have no need of changing it and on a remote server
it's not intelligent to remove your networking support and reload it.  The
process may fail and that leaves you dead.


> Please turn this off.

My vcard size is the same or smaller than the average signature.  Using mime, you
have the option of easily filtering vcards.  Signatures aren't as easily
identified for filtering.

-d


--------------523D952EC95F597556D7534F
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------523D952EC95F597556D7534F--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
