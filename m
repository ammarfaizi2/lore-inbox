Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUIVUSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUIVUSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUIVURg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:17:36 -0400
Received: from mail.enyo.de ([212.9.189.167]:6920 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S267254AbUIVUPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:15:10 -0400
To: Hisaaki Shibata <shibata@luky.org>
Cc: stern@rowland.harvard.edu, linux-usb-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Genesys and IEEE 1394 (was: Re: Genesys Logic and Kernel 2.4)
References: <20040709054435.GA31159@torres.ka0.zugschlus.de>
	<20040711.052727.607952779.shibata@luky.org>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Wed, 22 Sep 2004 22:15:01 +0200
In-Reply-To: <20040711.052727.607952779.shibata@luky.org> (Hisaaki Shibata's
	message of "Sun, 11 Jul 2004 05:27:27 +0900 (JST)")
Message-ID: <87d60eqcvu.fsf_-_@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hisaaki Shibata:

>> +		/* According to the technical support people at Genesys Logic,
>> +		 * devices using their chips have problems transferring more
>> +		 * than 32 KB at a time.  In practice people have found that
>> +		 * 64 KB works okay and that's what Windows does.  But we'll
>> +		 * be conservative.
>> +		 */
>> +		if (ss->pusb_dev->descriptor.idVendor == USB_VENDOR_ID_GENESYS)
>> +			ss->htmplt->max_sectors = 64;
>
> +			ss->htmplt.max_sectors = 64;
>
>> +

Christoph Biedl discovered that it's likely that a a similar
workaround is needed in the IEEE 1394 code:

http://sourceforge.net/mailarchive/forum.php?thread_id=5128811&forum_id=5389
