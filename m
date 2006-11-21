Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030806AbWKUKEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030806AbWKUKEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 05:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030808AbWKUKEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 05:04:42 -0500
Received: from nz-out-0102.google.com ([64.233.162.199]:62259 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030806AbWKUKEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 05:04:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=QreEcHfTrQCDhyUGhlyqCkkfR1LTRMLL2Gjd5QFdw83tn2UWLrB/rCCrkpJBmK2kz5RnY88dCKE4QNlg8LI6LaI2uaOklOQWl4xFWv6/rcodrNpDU/3utNrSdRS9HCHwKgi2guEkPGtN8fHMA2i8mxCVBMLy3bF30Ey/bW9qj3s=
Date: Tue, 21 Nov 2006 18:58:53 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: delete virtual directory on class_unregister()
Message-ID: <20061121095853.GA16279@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Greg KH <gregkh@suse.de>, Jiri Slaby <jirislaby@gmail.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <4561E290.7060100@gmail.com> <20061120182312.GA16006@APFDCB5C> <4561FA6F.4030400@gmail.com> <20061120195318.GB18077@APFDCB5C> <20061120203440.GA5458@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120203440.GA5458@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 12:34:40PM -0800, Greg KH wrote:
> 
> Hm, why is this not reproducable for me then without this patch?
> 

I can reproduce it by reloading raw.ko on 2.6.19-rc5-mm2.
not happened on 2.6.19-rc6.

After unloading raw.ko, /sys/devices/virtual/raw is still exist.
So next loading raw.ko will fail.

