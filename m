Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030768AbWJKDUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030768AbWJKDUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 23:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030769AbWJKDU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 23:20:29 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:39211 "EHLO
	asav00.insightbb.com") by vger.kernel.org with ESMTP
	id S1030768AbWJKDU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 23:20:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CAE/+K0WMCSw
From: Dmitry Torokhov <dtor@insightbb.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Tue, 10 Oct 2006 23:20:08 -0400
User-Agent: KMail/1.9.3
Cc: Yu Luming <luming.yu@gmail.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, len.brown@intel.com,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <200610102317.24310.luming.yu@gmail.com> <20061010212341.GA31972@srcf.ucam.org>
In-Reply-To: <20061010212341.GA31972@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610102320.13952.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 October 2006 17:23, Matthew Garrett wrote:
> On Tue, Oct 10, 2006 at 11:17:23PM +0800, Yu Luming wrote:
> 
> > Also, we need to make hot-key events  have similar handling code .
> > For example, Fn+F5 and Fn+F6 are brightness down and up key on my sony laptop.  
> > There is a driver called sonypi.c can map Fn+F5/F6 to KEY_FN_F5/F6. But I 
> > think It should be mapped to KEY_BRIGHTNESSDOWN/UP (linux/input.h)
> > Although, sonypi.c is NOT so clean, but , if it can report right event to 
> > input layer for all sony laptop(it works for me), and all related functions 
> > can be controlled through generic sysfs interface, then I would say sony has 
> > the best hot-key solution I have even seen so far for linux.
> 
> It would have to be DMI-based to some extent - not all Sonys use the 
> same keys for the same purpose. Misery ensues.
> 

Then we need to add keymap table to the sonypi's input device so that
keymap can be changed from userspace.

-- 
Dmitry
