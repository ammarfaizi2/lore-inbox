Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVATSI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVATSI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVATSFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:05:06 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:52114 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261586AbVATSEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:04:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZZ+QcXTQx1mv9tSaWQFopkKkoLkfFFNaZzxknjQGf3q5dhlzPDcdWMEvc/T9ViPX7xVZSHQdQCx1FtgpvahLvpyijbFzMJvAIFEdRnKFu1ao5SC5D7Tkjdb1ZcsCiqVVq7lAvyeO24az9Yg41MS2yaje7IGA8AZ5FdxR0zSqEVc=
Message-ID: <d120d5000501201004539f4c3@mail.gmail.com>
Date: Thu, 20 Jan 2005 13:04:03 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Richard Koch <n1gp@hotmail.com>
Subject: Re: [PATCH] adding the ICS MK712 touchscreen driver to 2.6
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz,
       linux-input@atrey.karlin.mff.cuni.cz, torvalds@osdl.org,
       trivial@rustcorp.com.au
In-Reply-To: <BAY16-F34ACC3DA65154E040BEC5987800@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <BAY16-F34ACC3DA65154E040BEC5987800@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005 16:18:49 -0500, Richard Koch <n1gp@hotmail.com> wrote:
> Please include the patch below to bring the ICS MK712 touchscreen controller
> support, which is in kernel 2.4, in to kernel 2.6.
> 
> This patch was constructed and applied to kernel version 2.6.10 and tested
> successfully on several Gateway AOL Connected Touchpad computers.
> 
> This was based on the mk712.c 2.4.28 version. No functional changes applied
> only minor
> changes to conform to the 2.6 build structure. I choose to place the driver
> under
> input/touchscreen as this seemed most appropriate.
> 

Hi,

I think that the driver should be integrated into 2.6 input system
before merging it into the kernel so touchscreen data can be accessed
through standard interfaces (evdev, mousedev, tsdev) without the need
for a special device.

Also MODULE_PARM is obsolete and shoudl be repleced with module_param().

-- 
Dmitry
