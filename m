Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276337AbRJKNkf>; Thu, 11 Oct 2001 09:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276335AbRJKNkZ>; Thu, 11 Oct 2001 09:40:25 -0400
Received: from jalon.able.es ([212.97.163.2]:5549 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S276330AbRJKNkO>;
	Thu, 11 Oct 2001 09:40:14 -0400
Date: Thu, 11 Oct 2001 15:40:39 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.10-ac11 parport_pc.c bugfix
Message-ID: <20011011154039.C3904@werewolf.able.es>
In-Reply-To: <1002766826.7434.38.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1002766826.7434.38.camel@thanatos>; from jdthood@mail.com on Thu, Oct 11, 2001 at 04:20:23 +0200
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011011 Thomas Hood wrote:
> 	} else {
>-		if ( dev->irq_resource[0].start == -1 ) {
>+		if ( dev->irq_resource[0].start == (unsigned long)-1 ) {
                                                   ^^^^^^^^^      ^
Uh ?

Perhaps I miss some black magic in kernel programming, but could not this
be written much cleaner like

>+		if ( dev->irq_resource[0].start == ~0U ) {

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.10-ac11-beo #2 SMP Thu Oct 11 02:41:04 CEST 2001 i686
