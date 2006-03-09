Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751918AbWCIVtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbWCIVtt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 16:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbWCIVtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 16:49:49 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:16278 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751918AbWCIVtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 16:49:49 -0500
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/usb usbaudio.c,1.172,1.173
From: Lee Revell <rlrevell@joe-job.com>
To: Clemens Ladisch <cladisch@users.sourceforge.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E1FHG2j-0001sX-Ln@sc8-pr-cvs1.sourceforge.net>
References: <E1FHG2j-0001sX-Ln@sc8-pr-cvs1.sourceforge.net>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 16:49:46 -0500
Message-Id: <1141940987.13319.71.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 23:58 -0800, Clemens Ladisch wrote:
> +static const char *usb_error_string(int err)
> +{
> +	switch (err) {
> +	case -ENODEV:
> +		return "no device";
> +	case -ENOENT:
> +		return "endpoint not enabled";
> +	case -EPIPE:
> +		return "endpoint stalled";
> +	case -ENOSPC:
> +		return "not enough bandwidth";
> +	case -ESHUTDOWN:
> +		return "device disabled";
> +	case -EHOSTUNREACH:
> +		return "device suspended";
> +	case -EINVAL:
> +	case -EAGAIN:
> +	case -EFBIG:
> +	case -EMSGSIZE:
> +		return "internal error";
> +	default:
> +		return "unknown error";
> +	}
> +}

Shouldn't a generic facility be created for this?  After all these are
standard error codes and it seem like other parts of the kernel might
want to do user friendly error reporting.

Lee

