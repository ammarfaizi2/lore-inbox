Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWEONT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWEONT3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 09:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWEONT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 09:19:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:62859 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964838AbWEONT2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 09:19:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kZe7a87/8/h3VjCic5FhoirwyfOf93X9k0RcQeIhNO97O5Ejtkj6mdswURkDxLs/bMY41EEN3m//guSEKhNz644NpbjTDpKrUILfGljrQKBqp+YJY8GIA8DJxsYPvpYDpjzgk9QmdGK5HklHwvGDnk6hx/hCwrS7N0aqLHYeVdU=
Message-ID: <70066d530605150619v1784a685sbd120a2716298b1e@mail.gmail.com>
Date: Mon, 15 May 2006 09:19:26 -0400
From: "Jaya Kumar" <jayakumar.video@gmail.com>
To: "Oliver Neukum" <oliver@neukum.name>
Subject: Re: [PATCH/RFC 2.6.16.5 1/1] usb/media/quickcam_messenger driver v2
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <70066d530605150550q55deb127w1ab2a4451b065a54@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605150849.k4F8nXDb031881@localhost.localdomain>
	 <200605151235.10690.oliver@neukum.name>
	 <70066d530605150550q55deb127w1ab2a4451b065a54@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/06, Jaya Kumar <jayakumar.video@gmail.com> wrote:
> drivers/usb/media % egrep "urb->status.*=" *.c
> <snip>
> konicawc.c:        urb->status = 0;
> se401.c:        urb->status=0;
> stv680.c:       urb->status = 0;
> usbvideo.c:     urb->status = 0;
> w9968cf.c:      urb->status = 0;
>

I guess since usb_submit_urb also inits the iso_frame_descs, the
following would also need to be changed:

konicawc.c:                urb->iso_frame_desc[i].status = 0;
ov511.c:                        urb->iso_frame_desc[i].status = 0;
usbvideo.c:             urb->iso_frame_desc[i].status = 0;
