Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbRERL5K>; Fri, 18 May 2001 07:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262303AbRERL5A>; Fri, 18 May 2001 07:57:00 -0400
Received: from [195.6.125.97] ([195.6.125.97]:3082 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S262302AbRERL4l>;
	Fri, 18 May 2001 07:56:41 -0400
Date: Fri, 18 May 2001 13:54:41 +0200
From: sebastien person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: [newbie] timer in module
Message-Id: <20010518135441.59bab0ce.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a network module that need to regularly get data from network
adaptater.
But I don't know if it safe to do a loop with a timer in the module.
e.g. I want to do something like that after ifconfig call :

while(1)
{
	timer call()
	get data()	//	these datas are specific to device
}

but I'm scared that will block the driver.
I've no experience of a regularly call that let the hand to the module.
My aim is to do a get data call every x seconds (x is variable).

Is it better to let an external program executing timer call and get data
call
via ioctl ?

In the case of a network module wich is able to send and receive data,
whats happen if the driver is sollicited when he received or send data ?
the tbusy bit is it designed to avoid this case ?

The module is it able to execute two different parts of the module code
at the same time ? (receiving data and handle a higher layer request)

thanks for any comments.

sebastien person
