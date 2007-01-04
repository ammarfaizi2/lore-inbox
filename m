Return-Path: <linux-kernel-owner+w=401wt.eu-S932338AbXADIma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbXADIma (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 03:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbXADIma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 03:42:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:7070 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932332AbXADIm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 03:42:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=kpZegRaoiQItA0cNZWHerAvVclKb+BGZvJ0zGNzmDT2f2dz2RSy4vcrqmPIjKhAzJim3qyVfUlidKC0KK4hx3C3WDNWCPUv0SocrOXz9EMFmX/heZDwyQeagU0MLPW4r008N4zx/ub1gTTqqs3cfB2FxC1vc/RjvDCtQwHuRtoM=
Date: Thu, 4 Jan 2007 09:42:24 +0100
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: rpjday@mindspring.com
Subject: Re: [PATCH] Simplify some code to use the container_of() macro.
Message-ID: <20070104084224.GA3630@unknown-00-0d-60-79-ca-00.lan>
Mail-Followup-To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	rpjday@mindspring.com
References: <Pine.LNX.4.64.0612311547200.30821@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612311547200.30821@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
From: Thomas Hisch <t.hisch@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 03:55:22PM -0500, Robert P. J. Day wrote:
> @@ -1810,8 +1809,7 @@ lcs_get_frames_cb(struct lcs_channel *channel, struct lcs_buffer *buffer)
>  		LCS_DBF_TEXT(4, trace, "-eiogpkt");
>  		return;
>  	}
> -	card = (struct lcs_card *)
> -		((char *) channel - offsetof(struct lcs_card, read));
> +	card = container_of(channel, struct lcs_card, write);
the last argument in container_of should be read instead of write.

>  	offset = 0;
>  	while (lcs_hdr->offset != 0) {

-- 
Thomas Hisch
e0625874@stud.tuwien.ac.at
