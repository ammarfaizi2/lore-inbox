Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWBBAuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWBBAuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 19:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWBBAuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 19:50:03 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:37553 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030231AbWBBAuC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 19:50:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D49kQ6XsmqYoFpX9pWTyKYOhAeGg9/7KRI1i6swMZfQfZPTsWeKLxZL9zn8NMBBDEUevyHNA04L0N6U9BBcTjdIflwRNnZtiBql/gAHPfMZ4a8z7yXcqxxn2pEKjlEzuCg7CpAPe2u1lm7pduL29mYU2TUmdCqHK5mfJuyqjJ5M=
Message-ID: <7f45d9390602011650g6826e4c3hb1197ead463f1f23@mail.gmail.com>
Date: Wed, 1 Feb 2006 17:50:01 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Liyitec PS/2 touch panel driver [PATCH]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060201002233.GA14212@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d9390601311459o45de3c34sd4d25fc7990c728d@mail.gmail.com>
	 <20060201002233.GA14212@mipter.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/06, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > +static void liyitec_disconnect(struct serio *serio)
> > +{
> > +     struct liyitec *liyitec = serio_get_drvdata(serio);
> > +
> > +     input_get_device(liyitec->dev);
>
> What do you want to do with return value?

As far as I know, input_get_device returns its argument. So, I don't
want anything with the return value. input_get_device does increment
the reference count of the underlying kobject though. Am I correct
here?

> > +static void __exit liyitec_exit(void)
> > +{
> > +     printk(KERN_INFO "liyitec: %s\n", __func__);
>
> I suggest to drop this line.

Right. Will do.

Please cc me in your reply. Cheers,
Shaun
