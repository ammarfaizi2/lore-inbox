Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVEQONK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVEQONK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 10:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVEQONK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 10:13:10 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:9796 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261294AbVEQONE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 10:13:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LBcNL1o94mI1ZZaAnCBK1OXrOSRJ/N6WHWBMndiPYxGheIDUwMRMEX4Rpu3QZ99t0B8g0+gtIEoB4GwxZE3FInGHJsxM//7IvqqFN3cCyT1I/5+c0iD7J/k7AbQcbcsYz/V1QUMaA/5gZk92vyZgWPQuPILCGSft+SNp6XnfdOc=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: ALSA make menuconfig Help description missing
Date: Tue, 17 May 2005 18:16:51 +0400
User-Agent: KMail/1.7.2
Cc: Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
References: <20050517123549.GA2378@kestrel> <s5hfywmotdd.wl@alsa2.suse.de>
In-Reply-To: <s5hfywmotdd.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505171816.52233.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 May 2005 17:49, Takashi Iwai wrote:
> At Tue, 17 May 2005 14:35:49 +0200,
> Karel Kulhavy wrote:
> > v2.6.11 make menuconfig -> Device Drivers -> Sound -> Advanced Linux
> > Sound Architecture and
> > 
> > v2.6.11 make menuconfig -> Device Drivers -> Sound -> Advanced Linux
> > Sound Architecture -> Advanced Linux Sound Architecture
> > 
> > are missing their help descriptions:
> > 
> > "There is no help available for this kernel option."
> > 
> > Therefore the user is unable to determine how to use this subsystem
> > at all.
> 
> Something like below fixes the problem?

> --- linux/sound/Kconfig
> +++ linux/sound/Kconfig
> @@ -42,6 +42,8 @@
>  config SND
>  	tristate "Advanced Linux Sound Architecture"
>  	depends on SOUND
> +	help
> +	  Say 'Y' or 'M' to enable ALSA (Advanced Linux Sound Architecture)

The only new info is that one can abbreviate "Advanced Linux Sound
Architecture" as "ALSA". ;-)

"Advanced Linux Sound Architecture" is already printed. What 'Y' and 'M' do is
also already printed at the top.
