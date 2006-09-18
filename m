Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965318AbWIRC1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965318AbWIRC1H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 22:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965316AbWIRC1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 22:27:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:12493 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965318AbWIRC1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 22:27:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JROHrgdLP0eOpHOrkeKy3D+GB5ZmquHH9r4HZtS2oko/6ZeTYFtJZmntX7HtknPs5D1H5R2Ggc6G5YWqosrdysJWJDvHZtPctz0JIFyXQeMvV5d5dbTsFxE8KRokE1LO0h/u+W8sZ0N111By5q3gr7NkZS6ZU6qlMnv/7YLOgOY=
Message-ID: <6b4e42d10609171927m6c2b6b84qb7708cfd2149b9e7@mail.gmail.com>
Date: Sun, 17 Sep 2006 19:27:03 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Dmitry Torokhov" <dtor@insightbb.com>
Subject: Re: kmalloc to kzalloc patches for drivers/base
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
In-Reply-To: <200609172108.37707.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6b4e42d10609171753m2a047081qc2982bf4a693a044@mail.gmail.com>
	 <200609172108.37707.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> On Sunday 17 September 2006 20:53, Om Narasimhan wrote:
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 2b8755d..e08950b 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -192,7 +192,7 @@ int platform_device_add_resources(struct
> > {
> > struct resource *r;
> >
> > -r = kmalloc(sizeof(struct resource) * num, GFP_KERNEL);
> > +r = kzalloc(sizeof(struct resource) * num, GFP_KERNEL);
> > if (r) {
> > memcpy(r, res, sizeof(struct resource) * num);
> > pdev->resource = r;
>
> Just out of curiosity could you tell me what is the benefit of
> zeroing allocated memory here?
My mistake. :-D
>
> > @@ -216,7 +216,7 @@ int platform_device_add_data(struct plat
> > {
> > void *d;
> >
> > -d = kmalloc(size, GFP_KERNEL);
> > +d = kzalloc(size, GFP_KERNEL);
> > if (d) {
> > memcpy(d, data, size);
> > pdev->dev.platform_data = d;
> >
>
> And here?
Mea Culpa :-D

Thanks for the comment.
Regards,
Om.
