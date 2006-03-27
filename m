Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWC0U4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWC0U4Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWC0U4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:56:24 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:62217 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751106AbWC0U4Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:56:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hFy4ZjatZcJx/3FElTIPQ43PMDDdS1kmZ/PGE6n2AXtegIj6UCRCv7tzkusyRUn7IUwmeZOtPT9Uwb/dNlpklJqXV2YX71D/mIIQUZ26m7hN73v1IhhTs+nF9hHkO97UI7JqAa6QAkh5ch7r0xQ5GxaUwD3s4nw4Zn8NlkWYoj0=
Message-ID: <d120d5000603271256g6ff971daq57282287fd1d5434@mail.gmail.com>
Date: Mon, 27 Mar 2006 15:56:17 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Bodo Eggert" <7eggert@gmx.de>
Subject: Re: [BUG] PS/2-mouse not found in 2.6.16
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0603272148050.2266@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0603272148050.2266@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/06, Bodo Eggert <7eggert@gmx.de> wrote:
> With kernel 2.6.16, my Logitech mouse is no longer detected (not reported
> in dmesg, not working).
>

Does it help if you comment out call to quirk_usb_handoff_ohci() (your
USB host controller is an OHCI one, isn't it?) in
drivers/usb/host/pci-quirks.c::quirk_usb_early_handoff()?

--
Dmitry
