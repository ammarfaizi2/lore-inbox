Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276843AbRJQNxJ>; Wed, 17 Oct 2001 09:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276840AbRJQNw7>; Wed, 17 Oct 2001 09:52:59 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:776 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S276836AbRJQNwi>;
	Wed, 17 Oct 2001 09:52:38 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jesper Juhl <juhl@eisenstein.dk>
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: console_loglevel is broken on ia64 
In-Reply-To: Your message of "Wed, 17 Oct 2001 15:39:06 +0200."
             <3BCD89FA.6050209@eisenstein.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Oct 2001 23:53:01 +1000
Message-ID: <3145.1003326781@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2001 15:39:06 +0200, 
Jesper Juhl <juhl@eisenstein.dk> wrote:
>Keith Owens wrote:
>> kernel/printk.c has this abomination.
>> int console_loglevel = DEFAULT_CONSOLE_LOGLEVEL;
>> int default_message_loglevel = DEFAULT_MESSAGE_LOGLEVEL;
>> int minimum_console_loglevel = MINIMUM_CONSOLE_LOGLEVEL;
>> int default_console_loglevel = DEFAULT_CONSOLE_LOGLEVEL;
>> Does anybody fancy a small project to clean up these variables?
>
>I would like to give it a try. Seems like a good little project for one 
>who is trying to learn his way around the kernel :)

Good, I was hoping for somebody who wanted to get started on the
kernel.  It's all yours, unless somebody else does a patch first.

Ensure that you find all references to these variables and make them
all use the common #define, instead of random files declaring the
variables themselves.  Check all architectures as well.

