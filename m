Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290221AbSAWXyO>; Wed, 23 Jan 2002 18:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290222AbSAWXyA>; Wed, 23 Jan 2002 18:54:00 -0500
Received: from firewall.esrf.fr ([193.49.43.1]:38796 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S290220AbSAWXw5>;
	Wed, 23 Jan 2002 18:52:57 -0500
Date: Thu, 24 Jan 2002 00:52:23 +0100
From: Samuel Maftoul <maftoul@esrf.fr>
To: Oliver.Neukum@lrz.uni-muenchen.de
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: umounting
Message-ID: <20020124005223.A23933@pcmaftoul.esrf.fr>
In-Reply-To: <20020122150703.B13509@pcmaftoul.esrf.fr> <16T6BH-1ZiPWiC@fwd07.sul.t-online.com> <20020123090614.A18262@pcmaftoul.esrf.fr> <16TVAs-0xKiHYC@fwd10.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <16TVAs-0xKiHYC@fwd10.sul.t-online.com>; from 520047054719-0001@t-online.de on Wed, Jan 23, 2002 at 10:42:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 10:42:33PM +0100, Oliver Neukum wrote:
> On Wednesday 23 January 2002 09:06, Samuel Maftoul wrote:
> > On Tue, Jan 22, 2002 at 08:01:44PM +0100, Oliver Neukum wrote:
> > > > When a second user comes and unmounts a disk, then the data are flushed
> > > > (the old data) and he gets a fs corruption, because the data were not
> > > > from his disk.
> > >
> > > No. The sbp2 driver should report a disk change. If such a thing happens,
> >
> > According to my log, sbp2 has an event, It does see the new disk as I
> > can mount it ( something bizarre: The first disk I plug, the sbp2 driver
> > tells me the vendor and model of the disk, but all other disk won't tell
> > me anything until I realod sbp2 module ( I think reloading is ok but not
> > tested
> 
> Do you use some kind of hotplugging script ?
yes, I use suse 7.2 with updated modutils and kernel to 2.4.17 ( from
unofficial suse rpm produced by suse ) and I'm using suse7.3's hotplug
with ieee1394.agent that I got through the hotplug cvs server
maybe to chemical :)

I think that anyway we should prevent this happens if it's possible.
( I didn't lost any data since I tested with some spare disk ).

I can also put a umount in my ieee1394.agent, I thought about it and
probably will do it.
> 
> 	Regards
> 		Oliver
