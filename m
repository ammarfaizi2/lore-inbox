Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131190AbQLMWgD>; Wed, 13 Dec 2000 17:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131502AbQLMWfx>; Wed, 13 Dec 2000 17:35:53 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:55558 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131190AbQLMWfr>;
	Wed, 13 Dec 2000 17:35:47 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: chris@chrullrich.de (Christian Ullrich), linux-kernel@vger.kernel.org
Subject: Re: insmod problem after modutils upgrading 
In-Reply-To: Your message of "Wed, 13 Dec 2000 21:10:54 -0000."
             <E146JAu-0003HX-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Dec 2000 09:05:13 +1100
Message-ID: <4381.976745113@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000 21:10:54 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>It is modutils. Their behaviour changed in a non back compatible way. Do not
>use modutils 2.3.22 with Linux 2.2.* is the simple answer. Perhaps Keith can
>make this a warning in 2.3.23

Adding persistent module data to modutils meant that insmod had to be a
lot more picky about MODULE_PARM() entries.  There were a few modules
that had invalid MODULE_PARM() entries, nobody had spotted them
previously because nobody used those options.  Since these are bugs in
the modules and only a few modules are affected (less than 5 reported),
the fix is to correct the modules that have coding errors.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
