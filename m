Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVACDGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVACDGx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 22:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVACDGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 22:06:53 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:11448 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261284AbVACDGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 22:06:52 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Date: Sun, 2 Jan 2005 22:06:50 -0500
User-Agent: KMail/1.6.2
Cc: Roey Katz <roey@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> <200501020152.32207.dtor_core@ameritech.net> <Pine.NEB.4.61.0501030250200.13940@sdf.lonestar.org>
In-Reply-To: <Pine.NEB.4.61.0501030250200.13940@sdf.lonestar.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501022206.50265.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 January 2005 09:53 pm, Roey Katz wrote:
> Dmitry, here is an output listing of a diff I did between the 
> .configs of the nonworking 2.6.10 and  the working 2.6.7.
> 

Roey,

Could you please try compiling a minimal kernel (no ACPI, no USB, etc)
to make sure that the changes to input system that were merged in 2.6.9
are to blame.

Also, if you could change #undef DEBUG to #define DEBUG in
drivers/input/serio/i8042.c and send me the entire dmesg output that
could help determining what is the problem. You may want to boot with
log_buf_len=131072 to capture entire dmesg. Don't forget to hit couple
of keys at the login prompt so we can see if we get them from the KBC
controller and loose them somewhere or the KBC is left in funky state.

Thanks!
 
-- 
Dmitry
