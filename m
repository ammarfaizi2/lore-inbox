Return-Path: <linux-kernel-owner+w=401wt.eu-S935734AbWLILZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935734AbWLILZZ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 06:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936902AbWLILZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 06:25:25 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:24595 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967798AbWLILZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 06:25:24 -0500
Date: Sat, 9 Dec 2006 12:25:10 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more work_struct mess
Message-ID: <20061209112515.GA1923@aepfle.de>
References: <20061208091649.GL4587@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061208091649.GL4587@ftp.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, Al Viro wrote:

> +++ b/sound/oss/dmasound/tas3001c.c

> @@ -823,7 +823,7 @@ tas3001c_init(struct i2c_client *client)
>  			tas3001c_write_biquad_shadow(self, i, j,
>  				&tas3001c_eq_unity);
>  
> -	INIT_WORK(&device_change, tas3001c_device_change_handler, self);
> +	INIT_WORK(&self->change, tas3001c_device_change_handler);

> +++ b/sound/oss/dmasound/tas3004.c

> @@ -1112,7 +1111,7 @@ tas3004_init(struct i2c_client *client)
>  	tas3004_write_register(self, TAS3004_REG_MCR2, &mcr2, WRITE_SHADOW);
>  	tas3004_write_register(self, TAS3004_REG_DRC, drce_init, WRITE_SHADOW);
>  
> -	INIT_WORK(&device_change, tas3004_device_change_handler, self);
> +	INIT_WORK(&self->change, tas3004_device_change_handler);


This is not enough to get it going:

error: 'INIT_WORK' undeclared (first use in this function)

