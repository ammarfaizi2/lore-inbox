Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271085AbRICCv2>; Sun, 2 Sep 2001 22:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271108AbRICCvS>; Sun, 2 Sep 2001 22:51:18 -0400
Received: from zok.SGI.COM ([204.94.215.101]:7102 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S271085AbRICCvJ>;
	Sun, 2 Sep 2001 22:51:09 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <laughing@shared-source.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac6 
In-Reply-To: Your message of "Mon, 03 Sep 2001 02:50:47 +0100."
             <20010903025047.A3117@lightning.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Sep 2001 12:51:21 +1000
Message-ID: <4165.999485481@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001 02:50:47 +0100, 
Alan Cox <laughing@shared-source.org> wrote:
>2.4.9-ac6

-ac4 added to arch/i386/kernel/setup.c::display_cacheinfo()

        if (c->x86_vendor == X86_VENDOR_CENTAUR && (c->x86 == 6) &&
                (c->x86_model == 7) || (c->x86_model == 8)) {

That should probably be

        if (c->x86_vendor == X86_VENDOR_CENTAUR && (c->x86 == 6) &&
                ((c->x86_model == 7) || (c->x86_model == 8))) {


