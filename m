Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291122AbSAaQCY>; Thu, 31 Jan 2002 11:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291123AbSAaQCP>; Thu, 31 Jan 2002 11:02:15 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:40456 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S291122AbSAaQB6>;
	Thu, 31 Jan 2002 11:01:58 -0500
Date: Thu, 31 Jan 2002 08:00:30 -0800
From: Greg KH <greg@kroah.com>
To: Kent Yoder <key@austin.ibm.com>
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: [PATCH] IBM Lanstreamer bugfixes (round 2)
Message-ID: <20020131160030.GA1343@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0201301651570.30238-100000@janetreno.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201301651570.30238-100000@janetreno.austin.ibm.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 03 Jan 2002 13:36:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Very minor suggestion:

On Thu, Jan 31, 2002 at 09:29:21AM -0600, Kent Yoder wrote:
> +	case IOCTL_SPIN_LOCK_TEST:
> +	        printk("spin_lock() called.\n");

You should add the proper KERN_* level to all of the printk() calls in
this ioctl function, as they do not seem to be protected with a 
#ifdef STREAMER_DEBUG, like other unclassified printk() calls in this
driver are.

thanks,

greg k-h
