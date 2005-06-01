Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVFAPta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVFAPta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVFAPrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:47:24 -0400
Received: from atpro.com ([12.161.0.3]:65038 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S261433AbVFAPpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:45:33 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Wed, 1 Jun 2005 11:42:46 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: kraxel@suse.de, toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com,
       ltd@cisco.com, linux-kernel@vger.kernel.org, dtor_core@ameritech.net,
       7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050601154245.GA14299@voodoo>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	kraxel@suse.de, toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com,
	ltd@cisco.com, linux-kernel@vger.kernel.org, dtor_core@ameritech.net,
	7eggert@gmx.de
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner> <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner> <87acmbxrfu.fsf@bytesex.org> <429DD036.nail7BF7MRZT6@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <429DD036.nail7BF7MRZT6@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/05 05:11:50PM +0200, Joerg Schilling wrote:
> > Not really.  Yes, it runs on different operating systems.  But to send
> > the SCSI commands to the device you have OS-specific code in there,
> > simply because it's handled in different ways on Solaris / Linux /
> > whatever OS.  You could make the device addressing OS-specific as well
> > instead of expecting everyone in the world follow the Solaris model,
> > that would make life a bit easier for everyone involved.
> 
> This is not the Solaris model....
> 
> I did define this model 19 years ago when I did write the first 
> Generic SCSI driver at all. Adaptec indepentently did develop ASPI
> 2 years later and did chose the same address model. Nearly all
> OS use this kind (or a very similar model) internaly inside the kernel
> or the basic SCSI address routines.

Just because it's old, that doesn't mean it's good. The kernel using the
numbers internally makes sense, but requiring them for userspace seems
stupid. All you should do is open the appropriate device node and let the
kernel figure out which SCSI ID to send the commands to. Every other tool
I've ever seen uses device nodes, why should cdrecord be different? All it
does is make cdrecord more difficult to use.

> 
> Jörg
> 

Jim.
