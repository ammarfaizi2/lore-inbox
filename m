Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVADPRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVADPRx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVADPRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:17:53 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:27493 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261671AbVADPRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:17:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jyPiAHLeTpgjDDOvl55Jn8xFr2aqJ6yC/561fZzZvcCnvhuZivKPy/WeMmMyW7iJWXMQu4nD+JF/UvYktM+fjvnus3CE0M2T7cNun8xhTaQrfYYj23u5Z/xyXZi17A3rvWpnALayityblVBxVI5TxKYd1cQEfRG05gHSmjy707M=
Message-ID: <d120d500050104071740f49126@mail.gmail.com>
Date: Tue, 4 Jan 2005 10:17:50 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [bk patches] Long delayed input update
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, vojtech@ucw.cz
In-Reply-To: <20050104145011.GB3097@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041227142821.GA5309@ucw.cz> <20050103131848.GH26949@ucw.cz>
	 <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org>
	 <200501040114.26499.dtor_core@ameritech.net>
	 <20050104145011.GB3097@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005 15:50:11 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> On Tue, Jan 04, 2005 at 01:14:26AM -0500, Dmitry Torokhov wrote:
> > When I do "make oldconfig" it silently sets SERIO_LIBPS2 to Y if I have
> > either atkbd or psmouse built-in and if both of them are modules it gives
> > option [M/y]. Do you have atkbd or psmouse selected?
> >...
> 
> As far as I can see, you are correct, and unless you are on !X86 or have
> EMBEDDED enabled SERIO_LIBPS2 is always forced to yes.
> 
> But although it doesn't seem to be a problem, I'm wondering why
> SERIO_LIBPS2 is a user-visible option?
> 

LIBPS2 is a mid-level library for accessing a device behing PS/2 port.
Like with CRC library there potentially could be some out-of-tree
moules using it so user has an option of building the library in the
kernel, or as a module, or omitting it.

For the vast majority of users it is selected automatically without any
questions.

-- 
Dmitry
