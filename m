Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317694AbSHGJeo>; Wed, 7 Aug 2002 05:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317708AbSHGJeo>; Wed, 7 Aug 2002 05:34:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10001 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317694AbSHGJen>; Wed, 7 Aug 2002 05:34:43 -0400
Date: Wed, 7 Aug 2002 10:38:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: kernel thread exit race
Message-ID: <20020807103819.B5934@flint.arm.linux.org.uk>
References: <15696.59115.395706.489896@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15696.59115.395706.489896@laputa.namesys.com>; from Nikita@Namesys.COM on Wed, Aug 07, 2002 at 01:22:51PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 01:22:51PM +0400, Nikita Danilov wrote:
> what is the politically correct way to exit from a kernel thread daemon
> without module unload races?

You need to use the completion stuff (see include/linux/completion.h)
Specifically complete_and_exit(), which is in include/linux/kernel.h
(for some weird reason).

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

