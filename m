Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273611AbTHFLIP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 07:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274996AbTHFLIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 07:08:15 -0400
Received: from www.13thfloor.at ([212.16.59.250]:57502 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S273611AbTHFLIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 07:08:10 -0400
Date: Wed, 6 Aug 2003 13:08:14 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Oliver Pitzeier <o.pitzeier@uptime.at>
Cc: "'Olaf Titz'" <olaf@bigred.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: chroot() breaks syslog() ?
Message-ID: <20030806110813.GA29792@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Oliver Pitzeier <o.pitzeier@uptime.at>,
	'Olaf Titz' <olaf@bigred.inka.de>, linux-kernel@vger.kernel.org
References: <000701c35bf6$b370ea70$020b10ac@pitzeier.priv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <000701c35bf6$b370ea70$020b10ac@pitzeier.priv.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 10:42:40AM +0200, Oliver Pitzeier wrote:
> > > IMHO, devfs in chroot environment, is defeating the purpose 
> > > because if you have access to raw devices, like the device
> > > your chroot dir is on, 
> > > you can easily mount that device again, and voila you have 
> > > access to 
> > > the full tree, if you
> > 
> > You need to be root to mount the device, and as root you can 
> > also create the device special file. A chroot environment 
> > does not reliably guard against root breaking out of it.
> 
> That's not completly wrong nor is it completly true. :)
> 
> You _CAN_ guard yourself from root's breaking out of some chroot environment.
> Using grsec (www.grsecurity.net). Denying double-chroots, creation of special
> files within chroot-environments and if you like it... Deny mounting within
> chroot. :)

hmm, how will you avoid creation of special (devicenodes)
files if I have raw access to any partition? I can 'simply'
use xxd to create my special inodes on the medium ...
and I would not care if mount is enabled or not when I
wipe the root partition with dd ...

best,
Herbert

> There are many options provided - just use 'em. :)
> 
> Best regards,
>  Oliver
