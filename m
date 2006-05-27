Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWE0Lls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWE0Lls (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 07:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWE0Lls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 07:41:48 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:21423 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1751471AbWE0Lls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 07:41:48 -0400
Date: Sat, 27 May 2006 13:41:18 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060527114118.GB12931@fks.be>
References: <20060526182217.GA12687@fks.be> <20060526133410.9cfff805.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526133410.9cfff805.zaitcev@redhat.com>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.813,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.09,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 01:34:10PM -0700, Pete Zaitcev wrote:
> On Fri, 26 May 2006 20:22:17 +0200, Frank Gevaerts <frank.gevaerts@fks.be> wrote:
> 
> > usb 1-4.5.7: USB disconnect, address 79
> > ------------[ cut here ]------------
> > kernel BUG at kernel/workqueue.c:110!
> 
> Please let me know if this helps:

It didn't help, I still get the error.

Frank

> 
> --- linux-2.6.17-rc2/drivers/usb/serial/usb-serial.c	2006-04-23 21:06:18.000000000 -0700
> +++ linux-2.6.17-rc2-lem/drivers/usb/serial/usb-serial.c	2006-05-22 21:23:29.000000000 -0700
> @@ -162,6 +162,8 @@ static void destroy_serial(struct kref *
>  		}
>  	}
>  
> +	flush_scheduled_work();		/* port->work */
> +
>  	usb_put_dev(serial->dev);
>  
>  	/* free up any memory that we allocated */
> 
> -- Pete

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19
