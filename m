Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267473AbUIFSeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267473AbUIFSeE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 14:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268453AbUIFSeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 14:34:04 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:55656 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267473AbUIFSeC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 14:34:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Synaptics detection not working reliably?
Date: Mon, 6 Sep 2004 13:33:59 -0500
User-Agent: KMail/1.6.2
Cc: =?iso-8859-1?q?Jos=E9_Orlando_Pereira?= <jop@lsd.di.uminho.pt>
References: <200409061449.47377.jop@lsd.di.uminho.pt>
In-Reply-To: <200409061449.47377.jop@lsd.di.uminho.pt>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409061333.59651.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 September 2004 08:49 am, José Orlando Pereira wrote:
> Hi,
> 
> There is something weird with Synaptics detection in 2.6.8.1 in a Fujitsu S7010
> laptop with a touchpad/stick combo. The problem is as follows:
> 
>  - The first time the driver is loaded, either compiled in or as a module and
> regardless of options provided, the mouse is detected as a bare PS/2:
> 

Most likely "USB Legacy emulation problem". Load psmouse module after loading
all USB modules so USB can disable the emulation mode before psmouse gets to
probe hardware.

-- 
Dmitry
