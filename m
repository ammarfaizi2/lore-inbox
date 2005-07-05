Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVGENPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVGENPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 09:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVGENPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 09:15:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30858 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261842AbVGENJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 09:09:31 -0400
Subject: Re: [git patches] IDE update
From: Jens Axboe <axboe@suse.de>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: =?ISO-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <42CA84DB.2050506@rainbow-software.org>
References: <200507042033.XAA19724@raad.intranet>
	 <42C9C56D.7040701@tomt.net> <42CA5A84.1060005@rainbow-software.org>
	 <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org>
	 <20050705104208.GA20620@suse.de>  <42CA7EA9.1010409@rainbow-software.org>
	 <1120567900.12942.8.camel@linux>  <42CA84DB.2050506@rainbow-software.org>
Content-Type: text/plain
Date: Tue, 05 Jul 2005 15:11:35 +0200
Message-Id: <1120569095.12942.11.camel@linux>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-05 at 15:02 +0200, Ondrej Zary wrote:
> > Ok, looks alright for both. Your machine is quite slow, perhaps that is
> > showing the slower performance. Can you try and make HZ 100 in 2.6 and
> > test again? 2.6.13-recent has it as a config option, otherwise edit
> > include/asm/param.h appropriately.
> > 
> 
> I forgot to write that my 2.6.12 kernel is already compiled with HZ 100 
> (it makes the system more responsive).
> I've just tried 2.6.8.1 with HZ 1000 and there is no difference in HDD 
> performance comparing to 2.6.12.

OK, interesting. You could try and boot with profile=2 and do

# readprofile -r
# dd if=/dev/hda of=/dev/null bs=128k 
# readprofile > prof_output

for each kernel and post it here, so we can see if anything sticks out.

-- 
Jens Axboe <axboe@suse.de>

