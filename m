Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWCTIpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWCTIpI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWCTIpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:45:08 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:34984 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932236AbWCTIpG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:45:06 -0500
Subject: Re: 2.6.16-rc6-rt3
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Jan Altenberg <tb10alj@tglx.de>
In-Reply-To: <441B756A.9060309@cybsft.com>
References: <20060314084658.GA28947@elte.hu> <4416C6DD.80209@cybsft.com>
	 <20060314142458.GA21796@elte.hu> <4416F14E.1040708@cybsft.com>
	 <20060317092351.GA18491@elte.hu> <441AE417.1030601@cybsft.com>
	 <20060317203149.GA23069@elte.hu>  <441B756A.9060309@cybsft.com>
Date: Mon, 20 Mar 2006 09:48:45 +0100
Message-Id: <1142844525.4668.1.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/03/2006 09:46:52,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/03/2006 09:46:56,
	Serialize complete at 20/03/2006 09:46:56
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 20:50 -0600, K.R. Foley wrote:
> Ingo Molnar wrote:
> > * K.R. Foley <kr@cybsft.com> wrote:
> > 
> >> OK. Tried rt9 with a clean build and still no joy. I've attached the 
> >> log which looks like it could be a similar problem?
> > 
> > seems to be a different one:
> > 
> >> input: ImPS/2 Generic Wheel Mouse as /class/input/input1
> >> Freeing unused kernel memory: 284k freed
> >> Could not allocate 8 bytes percpu data
> >> sd_mod: Unknown symbol scsi_print_sense_hdr
> > 
> > could you increase PERCPU_ENOUGH_ROOM in include/linux/percpu.h? (to 
> > e.g. 65536)
> > 
> > 	Ingo
> > 
> 
> Perhaps I misunderstood what you wanted me to do before. Just for grins
> I doubled the PERCPU_ENOUGH_ROOM to 131072 and have successfully booted
> twice now.
> 

  FYI, I bumped it to 196608 to play it safe, maybe 131072 could
be enough, never tried though.


-- 
-----------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
                   http://sourceforge.net/projects/paiol

-----------------------------------------------------

