Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbTFBR2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264811AbTFBR23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:28:29 -0400
Received: from [208.177.141.226] ([208.177.141.226]:33260 "HELO ash.lnxi.com")
	by vger.kernel.org with SMTP id S264808AbTFBR2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:28:22 -0400
To: "ganesh_borse" <ganesh_borse@indiatimes.com>
Cc: <ebiederman@lnxi.com>, <agnew@missl.cs.umd.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Request for help
References: <200305290413.JAA23492@WS0005.indiatimes.com>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 02 Jun 2003 11:49:01 -0600
In-Reply-To: <200305290413.JAA23492@WS0005.indiatimes.com>
Message-ID: <m3fzmsjroy.fsf@maxwell.lnxi.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am CC'ing linux-kernel as that is the general kernel list.  There
may be something even more focused on IDE issues but I am
not aware of it.

"ganesh_borse" <ganesh_borse@indiatimes.com> writes:

> Hi,
> 
> 
> I would like to request for a little help related to IDE controllers.
> 
> 
> I am trying to develop a device drive code for listing the devices connected to
> a ide controller at the time of kernel booting.
> 
> 
> 
> Is there any way to get which channels on ide controller has got devices and
> which devices? 

Yes.  But it is baroque.

> This I am trying to get even before the normal ide device driver
> has been setup. Are there ide controller commands to get this info? 

Not exactly.  The method is essentially you ping the drives to see
if they are there.

> Or is this
> info stored in registers of ide-controllers? 

Nope this information is not stored in registers.

> For this do we need to write
> assembly instructions on linux?

No.

But there is also nothing that allows you to force the module
order within the kernel.  So there are no guarantees you will
come before a normal IDE driver.  I assume from the questions
you intend to have this working in the linux kernel.

Eric

