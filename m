Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132208AbQKWAHI>; Wed, 22 Nov 2000 19:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132230AbQKWAG6>; Wed, 22 Nov 2000 19:06:58 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:23827 "EHLO smtp1.cern.ch")
        by vger.kernel.org with ESMTP id <S132208AbQKWAGt>;
        Wed, 22 Nov 2000 19:06:49 -0500
To: R.E.Wolff@bitwizard.nl (Rogier Wolff)
Cc: Mitchell Blank Jr <mitch@sfgoth.com>,
        Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
Subject: Re: [NEW DRIVER] firestream
In-Reply-To: <200011222305.AAA30264@cave.bitwizard.nl>
From: Jes Sorensen <jes@linuxcare.com>
Date: 23 Nov 2000 00:35:42 +0100
In-Reply-To: R.E.Wolff@bitwizard.nl's message of "Thu, 23 Nov 2000 00:05:18 +0100 (MET)"
Message-ID: <d366lflgvl.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rogier" == Rogier Wolff <R.E.Wolff@bitwizard.nl> writes:

Rogier> Mitchell Blank Jr wrote:
>> First, I'd like to make a couple points about driver style that I'm
>> trying to move towards with the ATM drivers.  You're free to take
>> them or leave them, but I want to eventually move the tree in this
>> direction.  * I don't like header files that define the registers
>> of the chip - since the header file is only included in the
>> driver's .c file you might as well just put the definitions there
>> (unless, of course, there is good reason to think that the
>> registers will be used in multiple drivers - unlikely in this case)
>> Having a seperate header file just serves to hamper searching
>> around the driver and cluttering the directory.

Rogier> I disagree vehemently.

Rogier> The header file should have 'static things' that for example a
Rogier> competing driver for the same chip could also use. The "driver
Rogier> defines" should theoretically be in a separate file. This
Rogier> rarely happens.

I guess this boils down to personal preference, I like to stick
register definitions in a seperate file as well.

I think the most important issue is when doing header files to make
sure they go with the driver code and not in include/linux unless
there really is a reason to expose them to user space. No reason to
export register definitions for Ethernet cards down there.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
