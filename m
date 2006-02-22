Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422640AbWBVCbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbWBVCbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWBVCbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:31:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64522 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422640AbWBVCbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:31:22 -0500
Date: Wed, 22 Feb 2006 03:31:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060222023121.GB4661@stusta.de>
References: <20060214152218.GI10701@stusta.de> <Pine.LNX.4.61.0602141912580.32490@yvahk01.tjqt.qr> <20060214182238.GB3513@stusta.de> <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr> <20060217163802.GI4422@stusta.de> <93564eb70602191933x2a20ce0m@mail.gmail.com> <20060220132832.GF4971@stusta.de> <20060222013410.GH20204@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222013410.GH20204@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 02:34:11AM +0100, Herbert Poetzl wrote:
> On Mon, Feb 20, 2006 at 02:28:32PM +0100, Adrian Bunk wrote:
> > On Mon, Feb 20, 2006 at 12:33:55PM +0900, Samuel Masham wrote:
> > 
> > > Hi Adrian,
> > 
> > Hi Samuel,
> > 
> > > > And I've already given numbers why CONFIG_EMBEDDED=y and
> > > > CONFIG_MODULES=y at the same time is insane.
> > > 
> > > >From your numbers this sounds true ... but actually you might want the
> > > modules to delay the init of the various hardware bits...
> > > 
> > > Sometime boot-time is king and you just try and get back as much of
> > > the size costs as it takes...
> > 
> > this is irrelevant since CONFIG_INPUT alone does not init any hardware.
> > 
> > > I think for EMBEDDED and MODULES is actually a very common case ... if
> > > somewhat odd.
> > 
> > You are misunderstanding EMBEDDED.
> 
> well, I suggested the following (or a similar)
> change some time ago (unfortunately I could not
> find it in the lkml archives, so it might have
> been lost)
> 
> http://vserver.13thfloor.at/Stuff/embedded_to_expert.txt

That's not a good solution since EMBEDDED is really only about 
additional space savings - even if you are an "expert", there's no 
reason to enable EMBEDDED when building a kernel for systems 
with > 50 MB RAM.

The better solution is IMHO an additional option:
  http://lkml.org/lkml/2006/2/7/93
  http://lkml.org/lkml/2006/2/7/139

> best,
> Herbert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

