Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbUKGDt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUKGDt7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 22:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUKGDt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 22:49:59 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:47226 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261533AbUKGDt5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 22:49:57 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] small input cleanup
Date: Sat, 6 Nov 2004 22:49:54 -0500
User-Agent: KMail/1.6.2
Cc: Adrian Bunk <bunk@stusta.de>, vojtech@suse.cz,
       linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <20041107031256.GD14308@stusta.de>
In-Reply-To: <20041107031256.GD14308@stusta.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411062249.54887.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 06 November 2004 10:12 pm, Adrian Bunk wrote:
> The patch below does the following cleanups under drivers/input/ :
> - make some needlessly global code static
> - remove the completely unused EXPORT_SYMBOL'ed function gameport_rescan

It will be used (but in some transformed) once I finish gameport sysfs
support, but it probably need not be exported.
 
> - make the EXPORT_SYMBOL'ed function ps2_sendbyte static since it isn't
>   used outside the file where it's defined

libps2 is a library for communicating with standard PS/2 device and while
the function is not currently used it is part of the interface. I would
like to leave the function as is.

-- 
Dmitry
