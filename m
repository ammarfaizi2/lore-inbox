Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbTCaP1D>; Mon, 31 Mar 2003 10:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbTCaP1D>; Mon, 31 Mar 2003 10:27:03 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60902 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261684AbTCaP1C>;
	Mon, 31 Mar 2003 10:27:02 -0500
Date: Mon, 31 Mar 2003 07:33:51 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: _VJ <vjose@icope.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Probs in printk
Message-Id: <20030331073351.2de6c47a.rddunlap@osdl.org>
In-Reply-To: <3E881337.50903@icope.com>
References: <3E881337.50903@icope.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003 15:36:47 +0530 _VJ <vjose@icope.com> wrote:

| Hi,
| 
| I'm using printk for the device driver I'm writing.It doesn't give the 
| output to my console and the only way I can get those is just using
| cat  /proc/kmsg.But what I want is to get console prints while I'm 
| running .Then I put the kernel image of the remote system where it used 
| to give console output.Still I'm not getting any output to the screen.I 
| tried to use console_print ....not giving any result to the console.So I 
| would like to know what can I do about this

The only time that I've had this kind of problem (that I recall),
I just had to use a KERN_printklevel attribute to print the message.
E.g.,
	printk(KERN_CRIT "where does this message go\n");

It can also help to change the console loglevel (Alt-SysRq-N, where
N is 1 digit, higher prints more messages [try 9]).

and what kernel version?  You should always give that info,
even when it's useless.  :)

--
~Randy
