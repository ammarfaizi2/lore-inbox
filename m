Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267396AbTAVJiX>; Wed, 22 Jan 2003 04:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267405AbTAVJiX>; Wed, 22 Jan 2003 04:38:23 -0500
Received: from ulima.unil.ch ([130.223.144.143]:29393 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S267396AbTAVJiW>;
	Wed, 22 Jan 2003 04:38:22 -0500
Date: Wed, 22 Jan 2003 10:47:25 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Jens Axboe <axboe@suse.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, cdwrite@other.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Message-ID: <20030122094725.GB4139@ulima.unil.ch>
References: <200301220823.h0M8NG2o022692@burner.fokus.gmd.de> <20030122083530.GA20780@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030122083530.GA20780@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 09:35:30AM +0100, Jens Axboe wrote:

> Sounds plausible. Patch attached. Anyone care to expand on _why_ these
> status bytes are shifted one bit?
> 
> ===== drivers/ide/ide-cd.c 1.35 vs edited =====
> --- 1.35/drivers/ide/ide-cd.c	Thu Nov 21 22:56:59 2002
> +++ edited/drivers/ide/ide-cd.c	Wed Jan 22 09:34:28 2003
> @@ -706,7 +706,7 @@
>  		 * scsi status byte
>  		 */
>  		if ((rq->flags & REQ_BLOCK_PC) && !rq->errors)
> -			rq->errors = CHECK_CONDITION;
> +			rq->errors = CHECK_CONDITION << 1;
>  
>  		/* Check for tray open. */
>  		if (sense_key == NOT_READY) {

Great ;-)

I'll test this tonight, thank you very much!!!

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
