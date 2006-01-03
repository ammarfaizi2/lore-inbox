Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWACTTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWACTTe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWACTTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:19:34 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:41129 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1751459AbWACTTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:19:33 -0500
Date: Tue, 03 Jan 2006 14:18:49 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on	Apple	PowerBooks
In-reply-to: <20060103191433.GA11169@hansmi.ch>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>,
       stelian@popies.net
Message-id: <1136315929.14744.2.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20051225212041.GA6094@hansmi.ch>
 <200512252304.32830.dtor_core@ameritech.net>
 <20051231235124.GA18506@hansmi.ch>
 <1136084207.4635.86.camel@localhost.localdomain>
 <20060102224640.GB27317@hansmi.ch> <1136255354.27583.77.camel@grayson>
 <20060103191433.GA11169@hansmi.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int usbhid_pb_fkeyslast = 0;
> +module_param_named(pb_fkeyslast, usbhid_pb_fkeyslast, bool, 0644);
> +MODULE_PARM_DESC(usbhid_pb_fkeyslast, "Use F keys only while pressing fn on PowerBooks");
> +
> +static int usbhid_pb_disablefnkeys = 0;
> +module_param_named(pb_disablefnkeys, usbhid_pb_disablefnkeys, bool, 0644);
> +MODULE_PARM_DESC(usbhid_pb_disablefnkeys, "Disable fn special keys on PowerBooks");
> +
> +static int usbhid_pb_disablekeypad = 0;
> +module_param_named(pb_disablekeypad, usbhid_pb_disablekeypad, bool, 0644);
> +MODULE_PARM_DESC(usbhid_pb_disablekeypad, "Disable keypad keys on PowerBooks");
> +#endif

For it to be useful, you have to not initialize them (since they are
static, they will be zero'd anyway). Initializing them defeats the
purpose.

static int usbhid_pb_fkeyslast;
etc.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

