Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318468AbSGaTrU>; Wed, 31 Jul 2002 15:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318469AbSGaTrU>; Wed, 31 Jul 2002 15:47:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65040 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318468AbSGaTrU>; Wed, 31 Jul 2002 15:47:20 -0400
Date: Wed, 31 Jul 2002 20:50:39 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Nick Martens <nickm@kabelfoon.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.29 compile error [undefined reference to `register_serial']
Message-ID: <20020731205039.C18153@flint.arm.linux.org.uk>
References: <200207311952.30547.nickm@kabelfoon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207311952.30547.nickm@kabelfoon.nl>; from nickm@kabelfoon.nl on Wed, Jul 31, 2002 at 07:52:30PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 07:52:30PM +0000, Nick Martens wrote:
> I am trying to compile 2.5.29 but I am running into some compilation problems 
> i have attached my .config

You need to enable:

> #
> # Serial drivers
> #
> # CONFIG_SERIAL_8250 is not set

this option.

(hmm, parport_serial is earlier in the config system; maybe we should
suck it into drivers/serial so the config system works as expected?)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

