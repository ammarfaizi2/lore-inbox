Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWGFOsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWGFOsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 10:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWGFOsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 10:48:10 -0400
Received: from smtp.ono.com ([62.42.230.12]:30016 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S1030304AbWGFOsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 10:48:08 -0400
Date: Thu, 6 Jul 2006 16:48:02 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-ID: <20060706164802.6085d203@werewolf.auna.net>
In-Reply-To: <20060706163646.735f419f@werewolf.auna.net>
References: <20060703030355.420c7155.akpm@osdl.org>
	<20060705234347.47ef2600@werewolf.auna.net>
	<20060705155602.6e0b4dce.akpm@osdl.org>
	<20060706015706.37acb9af@werewolf.auna.net>
	<20060705170228.9e595851.akpm@osdl.org>
	<20060706163646.735f419f@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 2.3.1cvs59 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 16:36:46 +0200, "J.A. Magallón" <jamagallon@ono.com> wrote:

> On Wed, 5 Jul 2006 17:02:28 -0700, Andrew Morton <akpm@osdl.org> wrote:
> 
> 
> This a shot till I can try to get a full dmesg.
> 
> http://belly.cps.unizar.es/~magallon/tmp/shot.jpg
> 
> Anyways, what I wanted to point above was that previous kernels talk
> about 'sda1(8,1)', and newer use 'dev(8,19)'.
> Perhaps somebedy did a strcpy( ... , "dev" ), instead of strcpy( ... , dev ) ?
> 

Hey !!. I disabled md and usb to get more useful messages in my screen, and
now I have realized that libata is managing my IDE drive !! And I did not
boot with any 'libata.atapi_enable'....

In -mm1,
sda -> 200Gb sata
hda -> HL-DT-ST DVDRAM GSA-4120B
hdb -> (zip drive)
hdc -> 120Gb ide
hdd -> DVD-ROM

In -mm6,

sda -> (zip drive) ?
sdb -> 120Gb
sdc -> 200Gb

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam01 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Wed
