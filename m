Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282805AbRLGL4W>; Fri, 7 Dec 2001 06:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285465AbRLGL4N>; Fri, 7 Dec 2001 06:56:13 -0500
Received: from ns.ithnet.com ([217.64.64.10]:10252 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S282805AbRLGLzw>;
	Fri, 7 Dec 2001 06:55:52 -0500
Date: Fri, 7 Dec 2001 12:55:30 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: m.luca@iname.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.17-pre5
Message-Id: <20011207125530.40a13b87.skraw@ithnet.com>
In-Reply-To: <23818.1007696586@kao2.melbourne.sgi.com>
In-Reply-To: <200112070012.BAA24810@webserver.ithnet.com>
	<23818.1007696586@kao2.melbourne.sgi.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Dec 2001 14:43:06 +1100
Keith Owens <kaos@ocs.com.au> wrote:

> On Fri, 07 Dec 2001 01:12:53 +0100, 
> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> >BTW, for the further ongoing of this patch, I ran into the question if
> >                                                                      
> >MODULE_PARM(type, "1-(16)i");                                         
> >                                                                      
> >would be a valid statement. I guess not. But if not, could some kind  
> >soul please explain to me how to get rid of the braces "(" ")" given  
> >in definitions from CONFIG stuff.                                     
> >                                                                      
> >E.g.:                                                                 
> >                                                                      
> >CONFIG_ME_BEING_DUMB (16)                                             
> 
> Don't do that.  CONFIG numbers are expected to be plain numbers, not
> expressions, e.g. CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16, not (16).
> Given the fragility of CML1 I would not be surprised if (16) broke some
> of the shell scripts.

Huh!!

There is a problem: I made a (really small) patch to Config.in saying:

   int  '  Maximum number of cards supported by HiSax' CONFIG_HISAX_MAX_CARDS 8

If I check this in the source, it gives me CONFIG_HISAX_MAX_CARDS as (8)

Can you check this out please. It doesn't look like I could do anything against
this.
How do you make your CONFIG-definitions come back without "()" ?

Regards,
Stephan
