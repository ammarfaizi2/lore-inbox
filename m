Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264516AbRFOUYt>; Fri, 15 Jun 2001 16:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264517AbRFOUYj>; Fri, 15 Jun 2001 16:24:39 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:47019 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264516AbRFOUYX>;
	Fri, 15 Jun 2001 16:24:23 -0400
Message-ID: <3B2A6EED.86A318F3@mandrakesoft.com>
Date: Fri, 15 Jun 2001 16:24:13 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ddstreet@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ps2 keyboard filter hook
In-Reply-To: <Pine.LNX.4.10.10106151345510.25518-200000@ddstreet.raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ddstreet@us.ibm.com wrote:
> In order to use these keyboards, a the standard PS/2 driver needs to behave a
> bit differently; thus attached is a modifcation to the PS/2 driver which allows
> other drivers to register with the PS/2 driver as 'filters'.  There is a
> arbitrary max number of 'filters' set to 1, which is a compile-time define.
> The registered drivers are called (in order of registration) for every scancode,
> and they may change or consume the scancode (or allow it to pass).  Also the
> 'filters' are given a function to send an variable-sized buffer to the keyboard
> output port; this function is synchronized using a semaphore which also
> coordinates with pckbd_leds().

Didn't we just conclude a discussion here on linux-kernel, which said
that patches which simply add hooks allowing proprietary extensions are
not accepted into the kernel?

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
