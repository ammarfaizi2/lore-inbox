Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289507AbSAVWhc>; Tue, 22 Jan 2002 17:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289498AbSAVWhY>; Tue, 22 Jan 2002 17:37:24 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:64263 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id <S289507AbSAVWhM>; Tue, 22 Jan 2002 17:37:12 -0500
Message-Id: <200201222237.g0MMb7a17456@enterprise.bidmc.harvard.edu>
Content-Type: text/plain; charset=US-ASCII
From: "Kristofer T. Karas" <ktk@bigfoot.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
Subject: Re: [Patch - 2.4.17++] Fix undefined ksym in minix.o, ext2.o, sysv.o
Date: Tue, 22 Jan 2002 17:37:07 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <200201222216.g0MMGj317058@enterprise.bidmc.harvard.edu> <3C4DE863.6E486FA5@mandrakesoft.com>
In-Reply-To: <3C4DE863.6E486FA5@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 January 2002 05:32 pm, Jeff Garzik wrote:
> "Kristofer T. Karas" wrote:
> > +EXPORT_SYMBOL(waitfor_one_page);
> No, it needs to be exported unconditionally.

Fair enough.  A "grep -r" showed it existing only in ./fs/ and only ref'd by 
ext2, sysv and minix; so I figured a conditional wrap-around wouldn't hurt.  
But I didn't stop to consider 3rd party modules...

Kris
