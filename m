Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUHDMyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUHDMyY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 08:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUHDMyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 08:54:24 -0400
Received: from styx.suse.cz ([82.119.242.94]:2946 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264702AbUHDMyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 08:54:21 -0400
Date: Wed, 4 Aug 2004 14:56:11 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Marko Macek <Marko.Macek@gmx.net>,
       Jesper Juhl <juhl-lkml@dif.dk>, Eric Wong <eric@yhbt.net>
Subject: Re: KVM & mouse wheel
Message-ID: <20040804125611.GA2922@ucw.cz>
References: <410FAE9B.5010909@gmx.net> <200408040025.20118.dtor_core@ameritech.net> <20040804071842.GA705@ucw.cz> <200408040738.55330.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408040738.55330.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 07:38:55AM -0500, Dmitry Torokhov wrote:
> On Wednesday 04 August 2004 02:18 am, Vojtech Pavlik wrote:
> > On Wed, Aug 04, 2004 at 12:25:19AM -0500, Dmitry Torokhov wrote:
> > 
> > > On Tuesday 03 August 2004 11:29 pm, Marko Macek wrote:
> > > > Jesper Juhl wrote:
> > > > 
> > > > > <>I also had problems with my KVM switch and mouse when I initially 
> > > > > moved to
> > > > > 2.6, but adding this kernel boot parameter fixed it, meybe it will help
> > > > > you as well : psmouse.proto=imps
> > > > 
> > > > This doesn't help. Only the patch I sent helps me. The problem is that the
> > > > even with psmouse.proto=imps or exps, the driver still probes for 
> > > > synaptics which I
> > > > consider a bug.
> > > > 
> > > 
> > > No it is not - Synaptics with a track-point on a passthrough port will have
> > > track-point disabled if it is not reset after probing for imps/exps.
> >  
> > Hmm, does the imps/exps probe succeed in this case?
> 
> No, it does not, at least not mine. It either does bare PS/2 or native, but
> there are other Synaptics touchpads that can also do imps.
 
Ok, so how about issuing a reset when the imps probe fails? That'd take
care of all the cases, and I suppose a Synaptics pad that can do imps
will not be confused by it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
