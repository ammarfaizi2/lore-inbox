Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbUKJLTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUKJLTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 06:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUKJLTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 06:19:53 -0500
Received: from smtp.loomes.de ([212.40.161.2]:12491 "EHLO falcon.loomes.de")
	by vger.kernel.org with ESMTP id S261263AbUKJLTv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 06:19:51 -0500
Subject: Re: [patch] 2.6.10-rc1-mm4: bttv-driver.c compile error
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com
In-Reply-To: <20041110082407.GA23090@bytesex>
References: <20041109074909.3f287966.akpm@osdl.org>
	 <1100018489.7011.4.camel@lb.loomes.de> <20041109211107.GB5892@stusta.de>
	 <1100037358.1519.6.camel@lb.loomes.de>  <20041110082407.GA23090@bytesex>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 10 Nov 2004 12:19:29 +0100
Message-Id: <1100085569.1591.6.camel@lb.loomes.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 09:24 +0100, Gerd Knorr wrote:
> > kobject_register failed for <NULL> (-17)
> 
> IIRC there was a bug in the driver base and a patch from Gred fixing
> that floating around, maybe that one helps?  If not, the please
> build with KALLSYMS enabled, so this blob here ...
> 
> > Call Trace:[<ffffffff80208fa6>] [<ffffffff80277a9b>]
> > [<ffffffff80278002>] 
> >        [<ffffffff802f8930>] [<ffffffff8010b0e8>] [<ffffffff8010ea03>] 
> >        [<ffffffff8010b050>] [<ffffffff8010e9fb>] 
> 
> ... will be translated into something readable.

here it is:

kobject_register failed forBA€ÿÿÿÿ (-17)

Call Trace:<ffffffff80209706>{kobject_register+70}
<ffffffff802781fb>{bus_add_driver+107} 
       <ffffffff80278762>{driver_register+50}
<ffffffff802f9090>{i2c_add_driver+96} 
       <ffffffff8010b0f7>{init+167} <ffffffff8010ea13>{child_rip+8} 
       <ffffffff8010b050>{init+0} <ffffffff8010ea0b>{child_rip+0} 
       
tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
tuner: type set to 33 (MT20xx universal) by bt878 #0 [sw]

This happens also when the patch from Andrew is being applied.


