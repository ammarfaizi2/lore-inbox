Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWGFOgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWGFOgs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 10:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWGFOgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 10:36:48 -0400
Received: from smtp.ono.com ([62.42.230.12]:51083 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S1030296AbWGFOgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 10:36:47 -0400
Date: Thu, 6 Jul 2006 16:36:46 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-ID: <20060706163646.735f419f@werewolf.auna.net>
In-Reply-To: <20060705170228.9e595851.akpm@osdl.org>
References: <20060703030355.420c7155.akpm@osdl.org>
	<20060705234347.47ef2600@werewolf.auna.net>
	<20060705155602.6e0b4dce.akpm@osdl.org>
	<20060706015706.37acb9af@werewolf.auna.net>
	<20060705170228.9e595851.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.3.1cvs59 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 17:02:28 -0700, Andrew Morton <akpm@osdl.org> wrote:

> On Thu, 6 Jul 2006 01:57:06 +0200
> "J.A. Magallón" <jamagallon@ono.com> wrote:
> >
> > > > 
> > > > With -mm6, the kernel doesn't find it. I get this on boot:
> > > > 
> > > > kinit: try_name sda,1 = dev(8,1)
> > > > kinit: name_to_dev_t(/dev/sda1) = dev(8.1)
> > > > kinit: root_dev = dev(8,1)
> > > > kinit: failed to identify filesystem /dev/root, trying all
> > > > kinit: trying to mount /dev/root on /root with type ext3
> > > > kinit: Cannot open root device dev(8,1)
> > > > 
> > > > I have tried to get this message from -mm1, but could not get it in any log.
> > > > But... I remember to see that the boot message is like:
> > > > 
> > > > kinit: try_name sda,1 = sda1(8,1)
> > > >                         ^^^^
> > > > I have verified I built -mm6 with ext3,sata-piix and so on, all builtin.
> > > > 
> > > 
> > > Are you able to test just 2.6.17 + origin.patch + git-libata-all.patch?
> > > 
> > > Also, the full dmesg from 2.6.17-mm6 would help, thanks.
> > > 
> > 
> > It does not reach a point to save the dmesg....
> > I can pick my digital camera.
> 
> Full dmesg would be better for this one, please.
> 

This a shot till I can try to get a full dmesg.

http://belly.cps.unizar.es/~magallon/tmp/shot.jpg

Anyways, what I wanted to point above was that previous kernels talk
about 'sda1(8,1)', and newer use 'dev(8,19)'.
Perhaps somebedy did a strcpy( ... , "dev" ), instead of strcpy( ... , dev ) ?

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam01 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Wed
