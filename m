Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281016AbRKMCes>; Mon, 12 Nov 2001 21:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281052AbRKMCei>; Mon, 12 Nov 2001 21:34:38 -0500
Received: from rj.sgi.com ([204.94.215.100]:59867 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S281016AbRKMCeX>;
	Mon, 12 Nov 2001 21:34:23 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: lobo@polbox.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: I'm sorry [it was: Nazi Kernels] 
In-Reply-To: Your message of "Tue, 13 Nov 2001 02:48:06 BST."
             <20011113024806.A13176@chello062179017166.chello.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Nov 2001 13:34:03 +1100
Message-ID: <9823.1005618843@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001 02:48:06 +0100, 
lobo@polbox.com wrote:
>Now after this introduction, I try to explain whats my problem with
>the new driver policy. When I try to load NVdriver to the kernel
>2.1.14, the modprobe (modutils 2.4.10) writes following line
>"Note: modules without a GPL compatible license cannot use \
>GPLONLY_ symbols".

If you had given the error message the first time instead of
complaining about Nazi kernels then you would have got a decent
response!

insmod issues that message when two conditions are both satisfied:

(1) The module has unresolved references *and*
(2) The module does not have a GPL license.

modprobe does not check if the unresolved references are exported as
GPLONLY or not, the message is jsut a hint about why the load /might/
have failed.  I should change the insmod text to make it more explicit
that this is only a possible explanation.

Since kernel 2.4.14 does not have any GPLONLY exports, your problem is
not that the kernel is restricting access to symbols.  Instead your
problem is that the binary only NVdriver does not match your kernel.
Ask NVidia for help.

Keith [Not a Nazi] Owens, modutils maintainer.

