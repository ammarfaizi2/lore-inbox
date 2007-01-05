Return-Path: <linux-kernel-owner+w=401wt.eu-S1161048AbXAEKjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbXAEKjM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 05:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbXAEKjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 05:39:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:61055 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161048AbXAEKjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 05:39:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=LsOdXpsb0++TzWzS9mtyGbEAFABEJndCpIlnKy5aT8l+ELF1XvsvM82sCs37VVR53V/sFvgscsNS1epNPaFmfew5lMcENmErODhCPXl9twuiT6RFXDOBl87I0DR+sCV0tVm9aNaVST1CWoveSfvR57GtKap7wJyNgR5d8BIpJsI=
Message-ID: <84144f020701050239q290849eahd3fc90af2c611d3@mail.gmail.com>
Date: Fri, 5 Jan 2007 12:39:08 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
Cc: "Ahmed S. Darwish" <darwish.07@gmail.com>,
       "Rolf Eike Beer" <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0701050513360.23145@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070105063600.GA13571@Ahmed>
	 <200701050910.11828.eike-kernel@sf-tec.de>
	 <20070105100610.GA382@Ahmed>
	 <Pine.LNX.4.64.0701050513360.23145@localhost.localdomain>
X-Google-Sender-Auth: 88b06213cbfaf9fd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/07, Robert P. J. Day <rpjday@mindspring.com> wrote:
> in this case, as mr. beer suggests, you should also check if this
> represents a kmalloc->kzalloc cleanup (there's lots of those), and
> also see if you can replace one of these:
>
>   sizeof(struct blah)
>
> with one of these:
>
>   sizeof(*blahptr)
>
> according to the CodingStyle guide.

Unfortunately, not all maintainers like sizeof() changes, so you're
better off leaving them as-is.
