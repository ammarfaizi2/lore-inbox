Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbTIPUZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 16:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbTIPUZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 16:25:27 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:24335 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262457AbTIPUZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 16:25:24 -0400
Date: Tue, 16 Sep 2003 22:25:22 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Remi Colinet <remi.colinet@wanadoo.fr>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5 : Bug in include/linux/input.h ?
Message-ID: <20030916222522.A1650@pclin040.win.tue.nl>
References: <3F6767AE.4090907@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F6767AE.4090907@wanadoo.fr>; from remi.colinet@wanadoo.fr on Tue, Sep 16, 2003 at 09:42:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 09:42:38PM +0200, Remi Colinet wrote:

> While reading the input code, I found the following error in 
> drivers/linux/input.h :
> 
>  #define INPUT_KEYCODE(dev, scancode) ((dev->keycodesize == 1) ? 
> ((u8*)dev->keycode)[scancode] : \
> -       ((dev->keycodesize == 1) ? ((u16*)dev->keycode)[scancode] : 
> (((u32*)dev->keycode)[scancode])))
> +       ((dev->keycodesize == 2) ? ((u16*)dev->keycode)[scancode] : 
> (((u32*)dev->keycode)[scancode])))

Yes.

(But we only use 1 if I am not mistaken, so no kernel behaviour changes.)

