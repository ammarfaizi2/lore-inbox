Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVBNBcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVBNBcP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 20:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVBNBcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 20:32:15 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:17824 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261329AbVBNBcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 20:32:12 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Stephen Evanchik <evanchsa@gmail.com>
Subject: Re: PATCH 2.6.11-rc4]: IBM TrackPoint configuration support
Date: Sun, 13 Feb 2005 20:31:01 -0500
User-Agent: KMail/1.7.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <a71293c2050213163253b9b98f@mail.gmail.com>
In-Reply-To: <a71293c2050213163253b9b98f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502132031.02214.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 February 2005 19:32, Stephen Evanchik wrote:
> Here is the latest IBM TrackPoint patch. I believe I made all of the
> necessary changes in this release including the removal of the
> middle-to-scroll functionality. One item I didn't address was a
> comment about checking the return code of ps2_command ..
> 
> I looked at other usages and it wasn't clear to me how to actually
> implement something that is sane. In some places an error causes a
> return out of the function and in others the return value is ignored.
> Should I check each return value or the first ?

I would check all 3 ps2_command calls in trackpoint_init and leave
the rest as is.

One more thing - I'd like to see more descriptive names of sysfs
attributes, for example I'd change "ptson" to "press_to_select",
"mb" to "middle_btn", etc.

-- 
Dmitry
