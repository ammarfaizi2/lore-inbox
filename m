Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934061AbWKWVLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934061AbWKWVLs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934060AbWKWVLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:11:48 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:50393 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S934061AbWKWVLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:11:47 -0500
Date: Thu, 23 Nov 2006 22:11:35 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-rt5
Message-ID: <20061123211135.GY18636@pengutronix.de>
References: <20061120220230.GA30835@elte.hu> <20061122113749.GY18636@pengutronix.de> <a0580c510611231243x318f3cbanc8fa2cbbedcec060@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <a0580c510611231243x318f3cbanc8fa2cbbedcec060@mail.gmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduardo,

On Thu, Nov 23, 2006 at 04:43:01PM -0400, Eduardo Valentin wrote:
> However, I got a similar problem as reported by Robert:
> 
> 2.6.19-rc6:
> T: 0 ( 4861) P:80 I:   10000 C:   10000 Min:    2592 Act:    4878 Avg:   6137 Max:   10652
> 2.6.19-rc6-rt5:
> T: 0 ( 3661) P:80 I:   10000 C:   10000 Min:     828 Act:    1698 Avg:   3291 Max:    7171
>
> These results are quite different from what is reported at the wiki.

Is this with -r or without? I didn't get fixed maxima at all on the
celeron box. It also looks like you've changed the interval time to
10ms; nevertheless: a delay of > 10 ms @ a cylce time of 10 ms means
missing the deadlines.

Do you have the possibility to switch off the SMI for your chipset? As
tglx noted on irc recently this may be dangerous because thermal
throtteling can be implemented via SMI, but to get an idea if the SMI is
the reason for the delays, switching it off for a short time should do
the job.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

