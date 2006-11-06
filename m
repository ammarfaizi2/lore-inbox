Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753465AbWKFRVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbWKFRVV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbWKFRVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:21:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:115 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753465AbWKFRVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:21:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=iL5i+cSBOetBDW+SKQewNzWPS666NOxkJYEcjhmXArq0fZEnjFVD/iHG7QokjSytzO31qefyZSJMdPaZnpYfS7t6M9hPPf27KAAtTV+fwxOTsH17YFAHECSpuRU2S+A11G+DVHy5Odgssk0Fg7ZOTGxDOHjsk3Yy27uwDL8/fJs=
Message-ID: <161717d50611060921s3e75fe5x8345da95c7bc910a@mail.gmail.com>
Date: Mon, 6 Nov 2006 12:21:18 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFT/PATCH] i8042: remove polling timer (v6)
Cc: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>
In-Reply-To: <d120d5000611060848k1f5fa2f7r7e78a0eca88a59ce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608232311.07599.dtor@insightbb.com>
	 <161717d50610291520i5076901blf8bf253eba6148cc@mail.gmail.com>
	 <200611030103.17913.dtor@insightbb.com>
	 <161717d50611060822w11e031ebra8f62d0fc5b02d69@mail.gmail.com>
	 <d120d5000611060848k1f5fa2f7r7e78a0eca88a59ce@mail.gmail.com>
X-Google-Sender-Auth: 2a424dfb24e0149a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> It would be interesting to see dmesg of reloading psmouse module after
> touchpad freezes:

Whoops, forgot to mention; I have extra printk's in now. At the time
of failure it's generally after  several "psmouse lost syncs" and
resyncs, and finally synaptics driver tries to do synaptics_reconnect
=> synaptics_query_hardware => synaptics_capability =>
synaptics_send_cmd => psmouse_sliced_command which fails (then the
freeze).
