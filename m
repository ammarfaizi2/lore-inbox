Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWIUNgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWIUNgm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 09:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWIUNgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 09:36:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:41362 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751145AbWIUNgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 09:36:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kaPm0gOYPbL5Y25IYWyMwr79JPHboV9Ucx6hLrDChAyv6STD/MTL5Et7qnUABgz+n7cJ63KmGdRSPJJLsam+eXa9qgw/CGD1ZLmPDpvIkWrHfRAmuZ+5mR62biTg1HXofTyJKB2PSUXOe6edFCV3/UzaoZ/nQ8yGENaZlHeYppQ=
Message-ID: <d120d5000609210636n49a35953w44aefe7068f286fd@mail.gmail.com>
Date: Thu, 21 Sep 2006 09:36:39 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Om Narasimhan" <om.turyx@gmail.com>
Subject: Re: kmalloc to kzalloc patches for drivers/atm [sane version]
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       linux-atm-general@lists.sourceforge.net
In-Reply-To: <6b4e42d10609210012j6c82379cs53fc374b675a5883@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6b4e42d10609210012j6c82379cs53fc374b675a5883@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/21/06, Om Narasimhan <om.turyx@gmail.com> wrote:
> -       dev->atm_vccs = kmalloc (dev->nchannels * sizeof (struct atm_vcc *),
> +       dev->atm_vccs = kcalloc (sizeof (struct atm_vcc *), dev->nchannels,
>                                 GFP_KERNEL);

kcalloc's first argument is number of elements to allocate, size is
the second argument.

>
> -       scq = (struct scq_info *) kmalloc(sizeof(struct scq_info), GFP_KERNEL);
> +       scq = (struct scq_info *) kzalloc(sizeof(struct scq_info), GFP_KERNEL);

Kill this cast please.

-- 
Dmitry
