Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTIQV4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbTIQV4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:56:32 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:60595 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S262850AbTIQV4b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:56:31 -0400
Date: Wed, 17 Sep 2003 23:56:25 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: James Simmons <jsimmons@infradead.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "David S. Miller" <davem@redhat.com>, <mroos@linux.ee>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Olaf Hering <olh@suse.de>
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
In-Reply-To: <Pine.LNX.4.44.0309172238511.1730-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.44.0309172350080.8954-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Sep 2003, James Simmons wrote:

>
> > Why don't you push it to 2.6 first then backport to 2.4 ? That would
> > be better imho...
>
>    I have a copy of the 2.6.X port. I tested it on my laptop at work but I
> get a funny matrix effect every 256 pixels on my display. It looks like
> that data from the early pixels is repeated even if it is distored.
> Basically what is in pixel 1 is displayed in pixel 256 but distorted and
> what is displayed in pixel 512 is what should be displayed at pixel 256
> but distorted. Also each distortion band is about 8 pixels wide.
>    I wouldn't submit it tho until I can test the patch on a sparc64
> myself to make sure it works.

This is also a display fifo issue. I think you need to get the display
fifo code in the 2.4 driver, I have been working with Geert in May to get
exactly the problem resolved on his VAIO, a Dell laptop I had temporarily
then had the problem too, it was because of lack of precision. It's likely
that Alexander didn't update his code yet.

Greetings,

Daniël Mantione

