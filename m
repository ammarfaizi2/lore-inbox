Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264244AbRGEVb6>; Thu, 5 Jul 2001 17:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264352AbRGEVbs>; Thu, 5 Jul 2001 17:31:48 -0400
Received: from t2.redhat.com ([199.183.24.243]:53238 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264244AbRGEVb2>; Thu, 5 Jul 2001 17:31:28 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <XFMail.20010705135733.davidel@xmailserver.org> 
In-Reply-To: <XFMail.20010705135733.davidel@xmailserver.org> 
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ... 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Jul 2001 22:31:12 +0100
Message-ID: <8505.994368672@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davidel@xmailserver.org said:
> This patch add a new linux/macros.h that is supposed to host utility
> macros that otherwise developers are forced to define in their files.
> This version contain only min(), max() and abs(). 

Consider min(x++,y++). Try:

#define min(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y); (_x>_y)?_y:_x; })
#define max(x,y) ({ typeof((x)) _x = (x); typeof((y)) _y = (y); (_x>_y)?_x:_y; })


--
dwmw2


