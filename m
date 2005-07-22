Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVGVO5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVGVO5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 10:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVGVO5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 10:57:18 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:33099 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S262106AbVGVO5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 10:57:17 -0400
Date: Fri, 22 Jul 2005 16:57:16 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux tty layer hackery: Heads up and RFC
Message-ID: <20050722145716.GA3332@bitwizard.nl>
References: <1121967993.19424.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121967993.19424.18.camel@localhost.localdomain>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 06:46:32PM +0100, Alan Cox wrote:
> int tty_prepare_flip_string(tty, strptr, len)
> 
> Adjust the buffer to allow len characters to be added. Returns a buffer
> pointer in strptr and the length available. This allows for hardware
> that needs to use functions like insl or mencpy_fromio.

Ok, So then I start copying characters into the flipstring, but how do
I say I'm done?

Or is there a race between that I call tty_prepare_flip_string, and
other processes start pulling my not-yet-filled string from the
buffer? (Surely not!)

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
