Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288473AbSA3EfZ>; Tue, 29 Jan 2002 23:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288477AbSA3EfE>; Tue, 29 Jan 2002 23:35:04 -0500
Received: from sombre.2ka.mipt.ru ([194.85.82.77]:45958 "EHLO
	sombre.2ka.mipt.ru") by vger.kernel.org with ESMTP
	id <S288473AbSA3Ee4>; Tue, 29 Jan 2002 23:34:56 -0500
Date: Wed, 30 Jan 2002 07:34:06 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jarno Paananen <jpaana@s2.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to avoid zombie kernel threads?
Message-Id: <20020130073406.20838f36.johnpol@2ka.mipt.ru>
In-Reply-To: <m3hep4qy79.fsf@kalahari.s2.org>
In-Reply-To: <m3hep4qy79.fsf@kalahari.s2.org>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jan 2002 06:06:50 +0200
Jarno Paananen <jpaana@s2.org> wrote:

> Hi,

Good time of day.

> that uses a kernel thread to do the actual work asynchronously from
> rest of the world. The thread is created when opening a character
> device and exits when the device is closed.

Maybe you should use do_exit() at the end or complete_and_exit()?

> [daemonize() etc.]
...
      do_exit(0); // At least usb hub do it in such manner.
>     return 0;


> Thanks,

I hope this will help you.

> // Jarno
> -

	Evgeniy Polyakov ( s0mbre ).
