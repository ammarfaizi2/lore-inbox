Return-Path: <linux-kernel-owner+w=401wt.eu-S1754707AbXAAVXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707AbXAAVXX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 16:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754708AbXAAVXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 16:23:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:12360 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707AbXAAVXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 16:23:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Pa4Tm4+KwM9PAHBD5SRFzm5M86yeRsHsAFBYUJNqtRCNNDMmwrcXGwFmXWfGfXWISgomVlgyW/X0qz0bpDz47pj5T3okVz01q6udYNILKvKUlzZu+nfjhR+tloM7i9FWdpGNhfcTOzgfi3hVk2EyU03TSs7sgDiLLzr9RL+yCeE=
Message-ID: <84144f020701011323w1350b9a9n2baa2245f716a221@mail.gmail.com>
Date: Mon, 1 Jan 2007 23:23:20 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Amit Choudhary" <amit2030@gmail.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061231161749.06e7f746.amit2030@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061231161749.06e7f746.amit2030@gmail.com>
X-Google-Sender-Auth: 6a6a8b9572a29930
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/07, Amit Choudhary <amit2030@gmail.com> wrote:
> +#define KFREE(x)               \
> +       do {                    \
> +               kfree(x);       \
> +               x = NULL;       \
> +       } while(0)

NAK until you have actual callers for it. CONFIG_SLAB_DEBUG already
catches use after free and double-free so I don't see the point of
this.
