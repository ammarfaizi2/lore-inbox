Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285397AbRLGDnr>; Thu, 6 Dec 2001 22:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285399AbRLGDni>; Thu, 6 Dec 2001 22:43:38 -0500
Received: from zok.sgi.com ([204.94.215.101]:53405 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S285397AbRLGDnT>;
	Thu, 6 Dec 2001 22:43:19 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Luca Montecchiani <m.luca@iname.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-pre5 
In-Reply-To: Your message of "Fri, 07 Dec 2001 01:12:53 BST."
             <200112070012.BAA24810@webserver.ithnet.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Dec 2001 14:43:06 +1100
Message-ID: <23818.1007696586@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Dec 2001 01:12:53 +0100, 
Stephan von Krawczynski <skraw@ithnet.com> wrote:
>BTW, for the further ongoing of this patch, I ran into the question if
>                                                                      
>MODULE_PARM(type, "1-(16)i");                                         
>                                                                      
>would be a valid statement. I guess not. But if not, could some kind  
>soul please explain to me how to get rid of the braces "(" ")" given  
>in definitions from CONFIG stuff.                                     
>                                                                      
>E.g.:                                                                 
>                                                                      
>CONFIG_ME_BEING_DUMB (16)                                             

Don't do that.  CONFIG numbers are expected to be plain numbers, not
expressions, e.g. CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16, not (16).
Given the fragility of CML1 I would not be surprised if (16) broke some
of the shell scripts.


