Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132382AbRA1KTx>; Sun, 28 Jan 2001 05:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135500AbRA1KTo>; Sun, 28 Jan 2001 05:19:44 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:58119 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132382AbRA1KTk>; Sun, 28 Jan 2001 05:19:40 -0500
Message-ID: <3A73F1EB.B6F69A93@transmeta.com>
Date: Sun, 28 Jan 2001 02:18:19 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <200101281012.LAA04278@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> 
> Ok. I've thought about it some more, but I don't care enough about
> this issue to do the painstaking legwork: I don't have one of those
> POST-code indicators on port 0x80.
> 
> I've made the "pause" in outb_p just a few (*) ns slower, because it
> now loads a variable before outputting the value to port 0x80. As the
> whole idea about this is "pausing", making it a bit slower shouldn't
> matter too much.  I've tested it: It compiles, it boots.
> 
> I'm not too familar with the syntax of the "asm" statement. So I may
> illegally be modifying the AX register. I don't care enough about this
> to figure it out right now.
> 

It is; you'd have to specify "eax" as a clobber value, and that is
undesirable.

And you're still overwriting the POST value written by the BIOS.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
