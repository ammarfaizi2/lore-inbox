Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274851AbRJNIjK>; Sun, 14 Oct 2001 04:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274875AbRJNIi7>; Sun, 14 Oct 2001 04:38:59 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:24972 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S274851AbRJNIiz>; Sun, 14 Oct 2001 04:38:55 -0400
Message-ID: <3BC94F3A.7F842182@welho.com>
Date: Sun, 14 Oct 2001 11:39:22 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
In-Reply-To: <3BC9393D.765A156@welho.com>
		<20011014.004744.51856957.davem@redhat.com>
		<3BC9441C.887258DA@welho.com> <20011014.011246.59654800.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
>    I don't control the remote machine, but it's linux (don't know which
>    version). I tried with both HTTP (Apache 1.3.9) and FTP. I doubt it's
>    the application. :-)
> 
> Well, the version of the kernel is pretty important.

Unfortunately I have no way to ascertain that, but I do know it's
running Debian. I would venture a guess that it's a series 2.2 kernel. I
tried a nmap fingerprint, but it couldn't identify the kernel.

> Setting PSH all the time does sound like a possibly familiar bug.

You have no problem with the reiceiver immediately acking PSH segments?
Shouldn't we be robust against this kind of behaviour? [Otherwise a
sender can force us into a permanent quickack mode simply by setting PSH
on every segment.]

Regards,

	MikaL
