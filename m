Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265280AbSJXAXE>; Wed, 23 Oct 2002 20:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265281AbSJXAXE>; Wed, 23 Oct 2002 20:23:04 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:6927 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265280AbSJXAXD>;
	Wed, 23 Oct 2002 20:23:03 -0400
Date: Wed, 23 Oct 2002 17:27:46 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorquk.ukuu.org.uk
Subject: Re: [PATCH] Advanced TCA SCSI/FC disk hotswap driver for kernel 2.5.44
Message-ID: <20021024002745.GI17413@kroah.com>
References: <3DB7304A.3030903@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB7304A.3030903@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 04:27:06PM -0700, Steven Dake wrote:
> +static ssize_t scsi_hotswap_insert_by_scsi_id_write_file (struct file 
> *file,
> +    const char *buf, size_t count, loff_t *ppos)
> +{
> +    int host, channel, lun, id;
> +    char parameters[1024];

Ouch, don't put 1k on the stack, dynamically allocate it please.

thanks,

greg k-h
