Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWA3UXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWA3UXT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWA3UXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:23:18 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:5568 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964947AbWA3UXQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:23:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jv7EsLvLwICGWelJd7kT1Z2nurq+w+dLbZ/MfmFtYgN7xcJ/QiDuOdbgE2Laz84KbsZxMCMUuMLQScCGbH3Fu0fFLZyjnSZ0N+i0HMUHVCTKk+6TncvYM+jcMcb30+TuY6o0+zhOxN2buPK7nm2jceD6JO1NvyKIKLbWas7e5dk=
Message-ID: <84144f020601301223j709ce2bco707ee73cf2d583b4@mail.gmail.com>
Date: Mon, 30 Jan 2006 22:23:15 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] record last user if malloc request is exact 4k
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060130174919.GA7599@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060130174919.GA7599@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/30/06, Olaf Hering <olh@suse.de> wrote:
> Is there a reason why a 4096 malloc is not recorded?
> untested patch below.
>
> allow SLAB_STORE_USER also with an exact 4k request.

For architectures that have 4K pages, adding debugging overhead to 4K
objects is pretty much the worst case. Any particular reason you want
this?

                              Pekka
