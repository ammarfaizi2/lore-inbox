Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKSWQN>; Sun, 19 Nov 2000 17:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129250AbQKSWQD>; Sun, 19 Nov 2000 17:16:03 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:55813 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129183AbQKSWPq>;
	Sun, 19 Nov 2000 17:15:46 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Gerd Knorr <kraxel@bytesex.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5 
In-Reply-To: Your message of "Sun, 19 Nov 2000 20:03:52 BST."
             <Pine.LNX.4.21.0011191956060.1015-100000@bogomips.masq.in-berlin.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 Nov 2000 08:45:39 +1100
Message-ID: <8863.974670339@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000 20:03:52 +0100 (CET), 
Gerd Knorr <kraxel@bytesex.org> wrote:
>On Mon, 20 Nov 2000, Keith Owens wrote:
>> On my list for 2.5.  If foo is declared as MODULE_PARM in object bar
>> then you will be able to boot with bar.foo=27 or even foo=27 as long as
>> variable foo is unique amongst all objects in the kernel.
>
>Cool.  Any plans how to handle drivers which are build from multiple
>object files like bttv?  Think "bar" needs to be configurable handle this
>nicely.  bttv should have bttv.card=xxx because the module is called
>"bttv", but the source file where the card insmod option is declared is
>bttv-cards.c ...

The prefix will come from the module name, not the source name, even
when the code is built into the kernel.  So in the case of bttv it will
be bttv.foo, not bttv-cards.foo.  That needs information from the
Makefile which is currently discarded, the Makefile processing for
multi object modules needs to be changed, which is why it is a 2.5
change.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
