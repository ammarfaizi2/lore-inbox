Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVEPJyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVEPJyV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 05:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVEPJyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 05:54:21 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:60594 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261529AbVEPJyR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 05:54:17 -0400
Subject: Re: ioctl to keyboard device file
From: Marcel Holtmann <marcel@holtmann.org>
To: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0505161418470.31612@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0505112207300.21632@lantana.cs.iitm.ernet.in>
	 <1115831651.23458.74.camel@pegasus>
	 <Pine.LNX.4.60.0505112301350.31722@lantana.cs.iitm.ernet.in>
	 <1115834000.23458.77.camel@pegasus>
	 <Pine.LNX.4.60.0505121454240.26644@lantana.cs.iitm.ernet.in>
	 <1115892091.18499.17.camel@pegasus>
	 <Pine.LNX.4.60.0505161418470.31612@lantana.cs.iitm.ernet.in>
Content-Type: text/plain
Date: Mon, 16 May 2005 11:54:01 +0200
Message-Id: <1116237241.10063.3.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>      My task is to send the characters to any application as if the input 
> is coming from keyboard. For that I created one character device file. To 
> it I am sending input characters through ioctl. In the character device 
> ioctl definition I am copying these user characters to kernel space and 
> sending these characters to handle_scancode function. What is the wrong 
> with this solution. This solution is working now. But waht I am asking is
> istead of sending our ioctl to newly created device file, can we able to 
> send ioctl to the keyboard buffer, so that avoiding the use of new 
> character device file , whose purpose is just to handle ioctl.

using uinput is the way to achieve this goal. What you did is an ugly
hack and I don't see any chance to get it merged back mainline.

> One more is, uinput case,
> 
> Whether uinput also doing the same thing, waht I am doing?
> For sending user data to kernel sapce we should use ioctl ,is it right?

This has nothing to do with ioctl() versus write(). Forget about it and
start using uinput.

Regards

Marcel


