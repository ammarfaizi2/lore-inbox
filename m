Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268147AbUHKSmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268147AbUHKSmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268164AbUHKSmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:42:38 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:29890 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S268147AbUHKSmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 14:42:36 -0400
Message-ID: <411A67C5.7020203@web.de>
Date: Wed, 11 Aug 2004 20:39:01 +0200
From: =?ISO-8859-1?Q?Fabian_Knei=DFl?= <fabian.kneissl@web.de>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.7 capidrv: how to deactivate logging capidrv events to active
 console
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have compiled kernel 2.6.7 with:
CONFIG_ISDN=y

CONFIG_ISDN_I4L=y
...

CONFIG_ISDN_CAPI=y
# CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON is not set
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPI20=y
CONFIG_ISDN_CAPI_CAPIFS_BOOL=y
CONFIG_ISDN_CAPI_CAPIFS=y
CONFIG_ISDN_CAPI_CAPIDRV=y

Then compiled the fritz-card kernel module from AVM.
Capi is working, and isdnlog too.
I need ISDN_I4L and ISDN_CAPI_CAPIDRV to get isdnlog working (for the 
/dev/isdnctrl device).

But with ISDN_CAPI_CAPIDRV and ISDN_I4L set, the kernel logs to the
active console whenever an event occurs on the isdn-line (e.g. someone
calls me).

Can I deactivate this logging somehow? I tried stopping klogd & syslogd, 
but that didn't help.
Or does anyone know another method of logging calls through the capi
interface?

Thank you,
Fabian


