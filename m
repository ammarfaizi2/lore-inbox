Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265152AbUGMOM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUGMOM1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUGMOM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:12:27 -0400
Received: from pop.gmx.net ([213.165.64.20]:6811 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265152AbUGMOMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:12:20 -0400
X-Authenticated: #19232476
Subject: Re: DriveReady SeekComplete Error...
From: Dhruv Matani <dhruvbird@gmx.net>
To: Evaldo Gardenali <evaldo@gardenali.biz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40F3D4AC.9050407@gardenali.biz>
References: <1089721822.4215.3.camel@localhost.localdomain>
	 <40F3D4AC.9050407@gardenali.biz>
Content-Type: text/plain
Organization: 
Message-Id: <1089728850.3240.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 Jul 2004 19:57:30 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 17:55, Evaldo Gardenali wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Dhruv Matani wrote:
> | Hi,
> | 	I've been getting this error for my brand new (2 months old) Samsung
> | HDD. The model Number is: SV0411N, and it is a 40GB disk. I'm using the
> | kernel version 2.4.20-8 provided by RedHat. When I used RH-7.2(before
> | upgrading to RH-9), the same HDD worked fine. Also, when I re-installed
> | RH-7.2, it worked fine?
> |
> | Any suggestions?
> |
> | Please cc me the reply, sine I'm not subscribed.
> | Thanks ;-)
> |
> 
> Hi there!
> on your kernel config, make sure you enable this:
> 
> 
> ~  lqqqqqqqqqqqqqqqqqqqqqqq Use multi-mode by default
> qqqqqqqqqqqqqqqqqqqqqqqk
> ~  x CONFIG_IDEDISK_MULTI_MODE:
> ~    x
> ~  x
> ~    x
> ~  x If you get this error, try to say Y here:
> ~    x
> ~  x
> ~    x
> ~  x hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }
> ~    x
> ~  x hda: set_multmode: error=0x04 { DriveStatusError }
> ~    x
> ~  x
> ~    x
> ~  x If in doubt, say N.

I don't think this will apply here, because the error that aI get
associated with the error is: 

Jul 12 00:19:52 localhost kernel: Freeing unused kernel memory: 92k
freed
Jul 12 00:19:52 localhost kernel: hda: dma_intr: status=0x51 {
DriveReady SeekComplete Error }
Jul 12 00:19:52 localhost kernel: hda: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Jul 12 00:19:52 localhost kernel: hda: dma_intr: status=0x51 {
DriveReady SeekComplete Error }
Jul 12 00:19:52 localhost kernel: hda: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Jul 12 00:19:52 localhost kernel: hda: dma_intr: status=0x51 {
DriveReady SeekComplete Error }
Jul 12 00:19:52 localhost kernel: hda: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Jul 12 00:19:52 localhost kernel: hda: dma_intr: status=0x51 {
DriveReady SeekComplete Error }
Jul 12 00:19:52 localhost kernel: hda: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Jul 12 00:19:52 localhost kernel: ide0: reset: success
Jul 12 00:19:52 localhost kernel: hda: dma_intr: status=0x51 {
DriveReady SeekComplete Error }
Jul 12 00:19:52 localhost kernel: hda: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Jul 12 00:19:52 localhost kernel: hda: dma_intr: status=0x51 {
DriveReady SeekComplete Error }
Jul 12 00:19:52 localhost kernel: hda: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Jul 12 00:19:52 localhost kernel: hda: dma_intr: status=0x51 {
DriveReady SeekComplete Error }
Jul 12 00:19:52 localhost kernel: hda: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Jul 12 00:19:52 localhost kernel: hda: dma_intr: status=0x51 {
DriveReady SeekComplete Error }
Jul 12 00:19:52 localhost kernel: hda: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Jul 12 00:19:52 localhost kernel: ide0: reset: success
Jul 12 00:19:52 localhost kernel: Real Time Clock Driver v1.10e

And not set_multimode.

I read somewhere, that some time interval has been changed to 20ms /
50ms, and 100ms was the previous one, and Samsung HDDs have been konking
off after that. What's this?

> ~    x
> ~  x
> ~    x
> ~  x
> ~    x
> ~  x
> ~    x
> ~  x
> ~    x
> ~  x
> ~    x
> ~  x
> ~    x
> ~  x
> ~    x
> ~  x
> ~    x
> 
> tqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq(100%)qqu
> 
> ~  x                                < Exit >
> ~    x
> 
> mqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqj
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> 
> iD8DBQFA89Ss5121Y+8pAbIRAio8AJ4sJ1ekYRSwVEoGBE90QIITqQyg0wCfXFaE
> npdo42iFQ0Le8Fzq7sXjGUg=
> =4aFw
> -----END PGP SIGNATURE-----
-- 
        -Dhruv Matani.
http://www.geocities.com/dhruvbird/

As a rule, man is a fool. When it's hot, he wants it cold. 
When it's cold he wants it hot. He always wants what is not.
	-Anon.


