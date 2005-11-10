Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVKJVBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVKJVBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVKJVBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:01:47 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:1742 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932111AbVKJVBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:01:46 -0500
Subject: Re: [Patch 02/20] V4L (930) Alsa fixes and improvements
From: Lee Revell <rlrevell@joe-job.com>
To: mchehab@brturbo.com.br
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, video4linux-list@redhat.com,
       Ricardo Cerqueira <v4l@cerqueira.org>, Takashi Iwai <tiwai@suse.de>,
       alsa-devel@lists.sourceforge.net
In-Reply-To: <1131656168.6478.39.camel@localhost>
References: <1131656168.6478.39.camel@localhost>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 15:59:47 -0500
Message-Id: <1131656388.8383.182.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 18:50 -0200, mchehab@brturbo.com.br wrote:
> -       struct saa7134_dev *dev = (struct saa7134_dev*) dev_id;
> +       snd_card_saa7134_t *saa7134 = dev_id;
> +       struct saa7134_dev *dev = saa7134->saadev; 

Don't use typedefs for stucts.  Yes, it's all over the place in ALSA,
but this will be changed very soon.

Lee

