Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267457AbTGHP1o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267461AbTGHP1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:27:44 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:50414 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S267457AbTGHP1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:27:41 -0400
Subject: Re: [PATCH] 2.5.74 boot logo
From: Martin Schlemmer <azarah@gentoo.org>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030708153028.61A304F11@gherkin.frus.com>
References: <20030708153028.61A304F11@gherkin.frus.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057678961.5499.433.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 08 Jul 2003 17:42:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-08 at 17:30, Bob Tracy wrote:
> Wouldn't look too good for this to be broken when 2.6 hits the
> streets :-).  The fix is trivial, and has been necessary since
> 2.5.70 at least (nearly two months ago).
> 
> --- orig/drivers/video/cfbimgblt.c	Mon May  5 17:39:49 2003
> +++ linux/drivers/video/cfbimgblt.c	Tue May 13 23:53:23 2003
> @@ -325,7 +325,7 @@
>  		else 
>  			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
>  					start_index, pitch_index);
> -	} else if (image->depth == bpp) 
> +	} else if (image->depth <= bpp) 
>  		color_imageblit(image, p, dst1, start_index, pitch_index);
>  }
>  

This has been fixed in James Simmons's tree, of which you can
get the latest 'snapshot' here:

  http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

They will be merged when the fbdev guys think its of good enough
quality *I think (tm)*.


Regards,

-- 
Martin Schlemmer


