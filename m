Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030532AbWBHFkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030532AbWBHFkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030535AbWBHFkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:40:45 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:5260 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030534AbWBHFko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:40:44 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [PATCH] Complain if driver reenables interrupts during drivers_[suspend|resume] & re-disable
Date: Wed, 8 Feb 2006 00:40:40 -0500
User-Agent: KMail/1.9.1
Cc: Linux PM <linux-pm@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <200602071906.55281.ncunningham@cyclades.com>
In-Reply-To: <200602071906.55281.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602080040.41495.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 04:06, Nigel Cunningham wrote:
> Hi all.
> 
> This patch is designed to help with diagnosing and fixing the cause of
> problems in suspending/resuming, due to drivers wrongly re-enabling
> interrupts in their .suspend or .resume methods. 
> 
> I nearly forgot about it in sending patches in suspend2 that might help
> where swsusp fails.
> 

Only sysdevs are guaranteed to be suspebded/resumed with interrupts off,
other devices are suspended with interrupts on (at least on first pass
over device list).

-- 
Dmitry
