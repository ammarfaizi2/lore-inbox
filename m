Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279642AbRJXX1C>; Wed, 24 Oct 2001 19:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279640AbRJXX0n>; Wed, 24 Oct 2001 19:26:43 -0400
Received: from mail.gmx.de ([213.165.64.20]:22439 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S279639AbRJXX0g>;
	Wed, 24 Oct 2001 19:26:36 -0400
Message-ID: <3BD74E4C.8A9BB52C@gmx.net>
Date: Thu, 25 Oct 2001 01:27:08 +0200
From: Mike <maneman@gmx.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Machine Check Exception in >2.4.5: Where to comment MCE out?
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id JAA14681

Hi,

I searched the LKML archive and found a 3-post-thread relevant to my
problem between July 4th-6th entitled:
"Re: 2.4.6: Machine Check Exception:  0x  106BE0  (type 0x   9)"  here:
<http://uwsg.iu.edu/hypermail/linux/kernel/0107.0/0470.html>
Like the Compaq mentioned in that post, I _also_ have a Compaq LTE 52xx
laptop (5250) which chokes on bootup.
I let this problem sit since 2.4.5 came out because that's when this
problem first occurred. Only recently did I get around to hunt down a
fix.

I understood that I was to "comment out" "MCE" in the sources.
So I did a 'grep -r 'MCE'  ./' in the sources and found bunch of
occurrences, the first ones being:
./include/asm-i386/processor.h:#define X86_CR4_MCE              0x0040
/* Machine check enable */
./include/asm-i386/cpufeature.h:#define X86_FEATURE_MCE         (0*32+
7) /* Machine Check Architecture */

So now my question is: what exactly should I comment out? One? Both? In
_all_ sources?
Please bear with me as I know next to nothing of C (or any language for
that matter).

Also: i'm not an LKML-subscriber so could you please CC: this to me?
Thanks and cheers,
-Mike
<maneman AT gmx DOT net>

ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
