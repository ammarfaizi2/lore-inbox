Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262628AbSI0VnI>; Fri, 27 Sep 2002 17:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262627AbSI0VnI>; Fri, 27 Sep 2002 17:43:08 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:24334 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262619AbSI0VnG>;
	Fri, 27 Sep 2002 17:43:06 -0400
Date: Fri, 27 Sep 2002 14:46:42 -0700
From: Greg KH <greg@kroah.com>
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] accessfs v0.6 ported to 2.5.35-lsm1 - 1/2
Message-ID: <20020927214642.GS12909@kroah.com>
References: <878z1rpfb4.fsf@goat.bogus.local> <20020926203716.GA7048@kroah.com> <87adm3i7nr.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87adm3i7nr.fsf@goat.bogus.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 08:55:52PM +0200, Olaf Dietsche wrote:
>  
> +static int cap_ip_prot_sock (int port)
> +{
> +	if (port && port < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
> +		return -EACCES;
> +
> +	return 0;
> +}
> +

Do we really want to force all of the security modules to implement this
logic (yes, it's the same discussion again...)

As for the ip_prot_sock hook in general, does it look ok to the other
developers?

thanks,

greg k-h
