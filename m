Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751939AbWJJHIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbWJJHIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 03:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbWJJHIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 03:08:41 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:13940 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751939AbWJJHIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 03:08:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=eV7RhSkSISjBxaZFEoauPaUIro9ZngQjWfqVneXnJaQKXiphx5KfjENjO87Avdc4WYgsElc3RbRLF/W6e9fYnKfDBf9OTv0X8WUI8Fv29H1QGVscwOtrzpE0Sj4xFobbfNGlqH2U8DfVpy9QP/W+SXSElYnnH/ICiS36rHrYe4E=
Message-ID: <452B46FF.90900@gmail.com>
Date: Tue, 10 Oct 2006 15:08:47 +0800
From: Liyu <raise.sail@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
CC: Anssi Hannula <anssi.hannula@gmail.com>, greg <greg@kroah.com>,
       Randy Dunlap <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>,
       "raise.sail@gmail.com" <raise.sail@gmail.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [PATCH] usb/hid: The HID Simple Driver	Interface
 0.3.2 (core)
References: <200609291624123283320@gmail.com>	<200610082342.26110.dtor@insightbb.com>	<452AD2D9.3090001@gmail.com> <200610100115.41449.dtor@insightbb.com>
In-Reply-To: <200610100115.41449.dtor@insightbb.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

    In hid-input, It seem we only call input_allocate_device(), but not
call input_free_device() at anywhere. Is there a memory leak here? Even,
I can not found this invoke in drivers/usb/hid*.c.

    Moreover, I found many usb input device driver do not call
input_free_device() at all, except when it failed to init itself.
   
    Are these purposely?

-Liyu



