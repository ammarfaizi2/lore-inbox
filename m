Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWGKNWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWGKNWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWGKNWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:22:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:6064 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750744AbWGKNV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:21:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g8L0Tn729mpHfhbl0QPM0bipzJWcXT3CIGHvtLbbpfbWv01aezwiFqBu4U4UxQDg7PgwMvmBtXV5UHnIUjwSuN9KJfaDUZWiOrFb6X2PO6LBddWSBpygd6OSCIsVV+rWBxuMbauDgSuaE14dVpgdB2Whz7DX628v9r2t0BihwvA=
Message-ID: <9e4733910607110621i720db936sebdd0bcb60fab4ad@mail.gmail.com>
Date: Tue, 11 Jul 2006 09:21:57 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbdev: Statically link the framebuffer notification functions
Cc: "Andrew Morton" <akpm@osdl.org>, rdunlap@xenotime.net, mreuther@umich.edu,
       linux-kernel@vger.kernel.org, zap@homelink.ru
In-Reply-To: <44B39D4D.8060209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607100833.00461.mreuther@umich.edu>
	 <20060710113212.5ddn42t40ks44s00@engin.mail.umich.edu>
	 <44B27931.30609@gmail.com> <200607102327.38426.mreuther@umich.edu>
	 <20060710215253.1fcaab57.rdunlap@xenotime.net>
	 <44B34D68.3080602@gmail.com> <20060711032817.94c78ae0.akpm@osdl.org>
	 <44B39D4D.8060209@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> The backlight and lcd subsystems can be notified by the framebuffer layer
> of blanking events.  However, these subsystems, as a whole, can function
> independently from the framebuffer layer. But in order to enable to
> the lcd and backlight subsystems, the framebuffer has to be compiled also,
> effectively sucking in a huge amount of unneeded code. Besides, the dependency
> is introducing a lot of compilation problems.

This code is effectively rebuilding a fb specific version of
inter_module_get/put., something that was removed earlier.

Another solution would be to put this code into a tiny module and then
have everyone depend on it.

-- 
Jon Smirl
jonsmirl@gmail.com
