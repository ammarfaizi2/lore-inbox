Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264827AbRGEWKf>; Thu, 5 Jul 2001 18:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264779AbRGEWKZ>; Thu, 5 Jul 2001 18:10:25 -0400
Received: from jalon.able.es ([212.97.163.2]:15005 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S264764AbRGEWKQ>;
	Thu, 5 Jul 2001 18:10:16 -0400
Date: Fri, 6 Jul 2001 00:10:29 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
Message-ID: <20010706001029.A11790@werewolf.able.es>
In-Reply-To: <8505.994368672@redhat.com> <XFMail.20010705144521.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <XFMail.20010705144521.davidel@xmailserver.org>; from davidel@xmailserver.org on Thu, Jul 05, 2001 at 23:45:21 +0200
X-Mailer: Balsa 1.1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010705 Davide Libenzi wrote:
>
>On 05-Jul-2001 David Woodhouse wrote:
>> 
>> davidel@xmailserver.org said:
>>> This patch add a new linux/macros.h that is supposed to host utility
>>> macros that otherwise developers are forced to define in their files.
>>> This version contain only min(), max() and abs(). 
>> 
>> Consider min(x++,y++). Try:
>> 
>>#define min(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y); (_x>_y)?_y:_x;
>>#})
>>#define max(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y); (_x>_y)?_x:_y;
>>#})
>
>Yep, it's better.

And there could be others also usefull:

#define ztst(x,y)	(x ?: y)   // `x' if that is nonzero; otherwise, of `y'

If g++ extensions worked in plain C, you just could write:
#define min(x,y) (x <? y)
#define max(x,y) (x >? y)

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.6-ac1 #2 SMP Thu Jul 5 01:15:49 CEST 2001 i686
