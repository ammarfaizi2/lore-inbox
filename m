Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030577AbVIPD7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030577AbVIPD7r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 23:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030590AbVIPD7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 23:59:47 -0400
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:22179 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030577AbVIPD7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 23:59:46 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 16/28] drivers/usb/input: convert to dynamic input_dev allocation
Date: Thu, 15 Sep 2005 22:59:33 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de, kay.sievers@vrfy.org,
       vojtech@suse.cz, hare@suse.de
References: <20050915070131.813650000.dtor_core@ameritech.net> <20050915070304.070090000.dtor_core@ameritech.net> <20050915205341.53c22b0e.akpm@osdl.org>
In-Reply-To: <20050915205341.53c22b0e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509152259.35027.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 September 2005 22:53, Andrew Morton wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> >
> >  Input: convert drivers/iusb/input to dynamic input_dev allocation
> 
> The absfuzz initialisation in kbtab_probe() got lost.
> 

Looks fine here:

+       input_set_abs_params(input_dev, ABS_X, 0, 0x2000, 4, 0);
+       input_set_abs_params(input_dev, ABS_X, 0, 0x1750, 4, 0);
                                                         ^^^

Is there something in your tree that not in Linus's yet? 

-- 
Dmitry
