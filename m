Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbUBUO6W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 09:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbUBUO6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 09:58:22 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:44561 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261565AbUBUO6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 09:58:21 -0500
Date: Sat, 21 Feb 2004 15:58:19 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Zephaniah E. Hull" <warp@mercury.d2dc.net>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com, greg@kroah.com
Subject: Re: [RFC 2.6] sensor chips sysfs interface change (long)
Message-Id: <20040221155819.7bc58609.khali@linux-fr.org>
In-Reply-To: <20040221131318.GA31688@babylon.d2dc.net>
References: <20040218220845.361341c9.khali@linux-fr.org>
	<20040221131318.GA31688@babylon.d2dc.net>
Reply-To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would like to further suggest the renaming of 'sensor<n>' to
> 'temp<n>_sensor' or 'temp<n>_type', in the interest of being
> consistent.

Correct. I was precisely thinking of something similar :) For the sake
of completeness, here is the list of renames that I plan to do:

temp<n>_hyst  -> temp<n>_max_hyst or temp<n>_crit_hyst
sensor<n>     -> temp<n>_type
pwm<n>        -> fan<n>_pwm
pwm<n>_enable -> fan<n>_pwm_enable
vid           -> in<n>_ref

I think that this should define a self-explanatory and easily extendable
interface. There are a few "technical" terms remaining (in, pwm, vrm),
but since these are the words used in the sensors domain, I feel like we
better keep them as they are.

Thanks a lot for your constructive comment, I appreciate that.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
