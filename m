Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWFXQTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWFXQTt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 12:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWFXQTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 12:19:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:18954 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750873AbWFXQTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 12:19:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=G+FOPacbF0XZJJRw6NuUNUPDPmwOxudRF7oIo8XktMC3ymbltRbnyraEqSkJJDWSpPPdkMxQ/ZL/pFD2CLCFhR1Uk9Z6ndrA5fxi1MkVvfzeyvjM9jo8hKAjnv20Tv3cJO9wLu5fFlvhQCjhmCbhLbijr3WHPhwM3k4KE++hyrg=
Message-ID: <84144f020606240919o53a38646lc4a46cd39c7a94fc@mail.gmail.com>
Date: Sat, 24 Jun 2006 19:19:45 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [PATCH] ext3_clear_inode(): avoid kfree(NULL)
Cc: "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <1151151104.3181.30.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606231502.k5NF2jfO007109@hera.kernel.org>
	 <449C3817.2030802@garzik.org> <20060623142430.333dd666.akpm@osdl.org>
	 <1151151104.3181.30.camel@laptopd505.fenrus.org>
X-Google-Sender-Auth: bbe5718794671255
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/06, Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > Because at that callsite, NULL is the common case.  We avoid a do-nothing
> > function call most of the time.  It's a nano-optimisation.
>
> but a function call is basically free, while an if () is not... even
> with unlikely()...

Yeah, but the called function has an if statement too...

                                   Pekka
