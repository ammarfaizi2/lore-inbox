Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266767AbRGFRkU>; Fri, 6 Jul 2001 13:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbRGFRkL>; Fri, 6 Jul 2001 13:40:11 -0400
Received: from daikokuya.demon.co.uk ([158.152.184.26]:58629 "EHLO
	monkey.daikokuya.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266767AbRGFRkC>; Fri, 6 Jul 2001 13:40:02 -0400
Date: Fri, 6 Jul 2001 18:38:04 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
Message-ID: <20010706183804.A13869@daikokuya.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15II3b-0003T8-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
From: Neil Booth <neil@daikokuya.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:-

> #define min(a,b) __magic_minfoo(a,b, __var##__LINE__, __var2##__LINE__)
> 
> #define __magic_minfoo(A,B,C,D) \
> 	{ typeof(A) C = (A)  .... }

No, that's buggy.  You need an extra level of indirection to expand
__LINE__.  Arguments to ## are inserted in-place without expansion.

Neil.
