Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbUJZGtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbUJZGtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 02:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUJZGtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 02:49:50 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:57752 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261924AbUJZGts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 02:49:48 -0400
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200410260121.46633.dtor_core@ameritech.net>
References: <200410210154.58301.dtor_core@ameritech.net>
	 <200410250822.46023.dtor_core@ameritech.net>
	 <1098744035.7191.49.camel@desktop.cunninghams>
	 <200410260121.46633.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1098772877.5807.1.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 26 Oct 2004 16:41:18 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-10-26 at 16:21, Dmitry Torokhov wrote:
> On Monday 25 October 2004 09:28 pm, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Mon, 2004-10-25 at 23:22, Dmitry Torokhov wrote:
> > > The change from sysdev to a platform device is the main reason I did
> > > the change (and getting rid of old pm_register stuff which is useless
> > > now) because swsusp2 (and seems that swsusp1 as well) have trouble
> > > resuming system devices. The rest was just fluff really.
> > 
> > I'm not sure why we're not trying to resume system devices. I'll give it
> > a whirl and see if anything breaks :> Feel free to tell me if/when you
> > notice things like this in future; I try to be approachable and
> > responsive.
> > 
> 
> Hi Nigel,
>  
> System devices are resumed when you call device_power_up and I could
> not find references to it in swsusp2 code, it goes straight to
> device_resume_tree... Am I missng something?

No, you weren't. I was following the pattern of Patrick and Pavel. I've
changed it this afternoon and have it running fine, except that the PIC
timer code takes a few seconds (see separate message).

The changes will be in 2.1.1. I just have a couple more little fixes to
do before I release it.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.

