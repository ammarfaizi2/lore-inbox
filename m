Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWACOq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWACOq2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWACOq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:46:28 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:5136 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932388AbWACOq1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:46:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pzbCLcQmwsQT/l03FOfXbB7isGziQcjAkipGV/+1xMVfBkH4Y95GAam6mi3UJgkYX6mX/jUkwqeJxaHsrX5/PNKos9+MM/5nrSuvTxAHyE/lrnT5otvG/uoQCnF7NQ9P+CZxGnAV1lDCewYSAWPRfCWofTQ5fqJ3DyHTFuXHJ9k=
Message-ID: <d120d5000601030646u4dfe2951ka26586050cac5f0b@mail.gmail.com>
Date: Tue, 3 Jan 2006 09:46:26 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: usb: replace __setup("nousb") with __module_param_call
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20060102230714.3aa4f85b.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051220141504.31441a41.zaitcev@redhat.com>
	 <200512220110.52466.dtor_core@ameritech.net>
	 <20051222002423.1791d38b.zaitcev@redhat.com>
	 <200601030147.46504.dtor_core@ameritech.net>
	 <20060102230714.3aa4f85b.zaitcev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/06, Pete Zaitcev <zaitcev@redhat.com> wrote:
> On Tue, 3 Jan 2006 01:47:46 -0500, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> > +static int __init obsolete_checksetup(char *line, int len)
> > -             int n = strlen(p->str);
> > -             if (!strncmp(line, p->str, n)) {
> > +             if (!strncmp(line, p->str, len) && len == strlen(p->str)) {
>
> This looks like it should work, with the disclaimer that I am not
> infallible.
>

;)

> But even if it does, my patch saved reading, so I think it should be
> applied as well.

What you mean by "saved reading"?

Btw, do we really need to export "nousb" in sysfs?

--
Dmitry
