Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276350AbRJKNxZ>; Thu, 11 Oct 2001 09:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276370AbRJKNxP>; Thu, 11 Oct 2001 09:53:15 -0400
Received: from sushi.toad.net ([162.33.130.105]:22505 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S276350AbRJKNxD>;
	Thu, 11 Oct 2001 09:53:03 -0400
Subject: Re: [PATCH] 2.4.10-ac11 parport_pc.c bugfix
From: Thomas Hood <jdthood@mail.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011011154039.C3904@werewolf.able.es>
In-Reply-To: <1002766826.7434.38.camel@thanatos> 
	<20011011154039.C3904@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 11 Oct 2001 09:52:27 -0400
Message-Id: <1002808349.10317.7.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess the question is: Which way is more portable?  Is
"(unsigned long)-1" liable to turn out as something other than
~0U?

If your way of expressing it is more portable then we should
make the change ... BOTH in pnp_bios.c and in parport_pc.c .

Opinions?

--
Thomas


On Thu, 2001-10-11 at 09:40, J . A . Magallon wrote:
> 
> On 20011011 Thomas Hood wrote:
> > 	} else {
> >-		if ( dev->irq_resource[0].start == -1 ) {
> >+		if ( dev->irq_resource[0].start == (unsigned long)-1 ) {
>                                                    ^^^^^^^^^      ^
> Uh ?
> 
> Perhaps I miss some black magic in kernel programming, but could not this
> be written much cleaner like
> 
> >+		if ( dev->irq_resource[0].start == ~0U ) {
> 
> -- 
> J.A. Magallon                           #  Let the source be with you...        
> mailto:jamagallon@able.es
> Mandrake Linux release 8.2 (Cooker) for i586
> Linux werewolf 2.4.10-ac11-beo #2 SMP Thu Oct 11 02:41:04 CEST 2001 i686
> 


