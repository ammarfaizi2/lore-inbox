Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264407AbUD2NAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264407AbUD2NAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 09:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbUD2NAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 09:00:20 -0400
Received: from mail9.messagelabs.com ([194.205.110.133]:35052 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S264407AbUD2M77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:59:59 -0400
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-12.tower-9.messagelabs.com!1083243624!7956878
X-StarScan-Version: 5.2.10; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Subject: Re: [PATCH] 2.6 I2C epson 8564 RTC chip
From: Ian Campbell <icampbell@arcom.com>
To: stefan.eletzhofer@eletztrick.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
In-Reply-To: <20040429120250.GD10867@gonzo.local>
References: <20040429120250.GD10867@gonzo.local>
Content-Type: text/plain
Organization: Arcom Control Systems
Message-Id: <1083243580.26762.38.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Apr 2004 13:59:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-29 at 13:02, stefan.eletzhofer@eletztrick.de wrote:
> This driver only does the low-level I2C stuff, the rtc misc device
> driver is a separate driver module which I will send a patch for soon.

By the way -- I notice you have said you need i2c_get_client for your
RTC driver to locate the i2c chip it wants to work with. 

Just a thought -- perhaps it would make sense to reverse the roles and
for the rtc driver to export a 'register_rtc_device' type call which the
specific i2c chip driver could then call to hook itself up to /dev/rtc

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
