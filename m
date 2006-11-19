Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933351AbWKSVaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933351AbWKSVaj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933355AbWKSVaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:30:39 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11410 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S933351AbWKSVai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:30:38 -0500
Subject: Re: Siemens SX1: sound cleanups
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
In-Reply-To: <20061119114938.GA22514@elf.ucw.cz>
References: <20061119114938.GA22514@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 19 Nov 2006 16:30:25 -0500
Message-Id: <1163971825.22176.91.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-19 at 12:49 +0100, Pavel Machek wrote:
> +int set_mixer_volume(int mixer_vol)
>  {
> -       int retVal;
> +       /* FIXME: Alsa has mixer_vol in 0-100 range, while SX1 needs
> 0-9 range */

Untrue.  ALSA uses whatever range you define in the info callback for
the mixer element.  I guess it just defaults to 0-100 if you don't set
it.

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x967.htm#CONTROL-INTERFACE-CALLBACKS-INFO

Lee

