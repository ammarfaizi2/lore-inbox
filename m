Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271336AbTGQCHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 22:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271334AbTGQCHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 22:07:02 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:2258 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S271335AbTGQCHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 22:07:00 -0400
Message-ID: <3F16083F.6040102@netcabo.pt>
Date: Thu, 17 Jul 2003 03:21:51 +0100
From: Miguel Sousa Filipe <m3thos@netcabo.pt>
Organization: IST-RNL
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.4) Gecko/20030713
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Too much debug info in PPC iBook through evbug_event()
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jul 2003 02:17:04.0268 (UTC) FILETIME=[8397B4C0:01C34C09]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't if this is supposed to happen, but my iBook just after boot was swamped 
with debug information every time I pressed some key, moved my mouse or pressed 
any mouse button.

The debug information came from:

drivers/input/evbug.c:
static void evbug_event(struct input_handle *handle, unsigned int type, unsigned 
int code, int value)
{
     printk(KERN_DEBUG "evbug.c: Event. Dev: %s, Type: %d, Code: %d, Value: 
%d\n", handle->dev->phys, type, code, value);
}

The system was unusable, since typing the username meant flooding the screen 
with several lines of debug info.


Miguel Sousa Filipe

