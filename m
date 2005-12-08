Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVLHVGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVLHVGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVLHVGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:06:39 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:41005 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932306AbVLHVGi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:06:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RCKQyekI4lHrkMuJBbB8us4X/EmGkcbID9BoGEP2K/NJDGi+aUDpkKMFC4n4O24shLJi7V2Ej6HmaeqR2EB58moI4g5/LdE0M0Ij0bfS4YDCHjiMR7BIzui3EbH3cdE51vRb+McdhzsmZd5bzfeT6NGxRbryQ+qELG8CcQfWF8c=
Message-ID: <d120d5000512081306t101c959cnf6b91f3fc417fbd6@mail.gmail.com>
Date: Thu, 8 Dec 2005 16:06:36 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051208215815.3d001dab.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051205202707.GH15201@flint.arm.linux.org.uk>
	 <20051207180842.GG6793@flint.arm.linux.org.uk>
	 <d120d5000512071023u151c42f4lcc40862b2debad73@mail.gmail.com>
	 <20051207190352.GI6793@flint.arm.linux.org.uk>
	 <d120d5000512071418q521d2155r81759ef8993000d8@mail.gmail.com>
	 <20051207225126.GA648@kroah.com>
	 <d120d5000512071459s9b461d8ye7abc41d0e1950fd@mail.gmail.com>
	 <20051207230615.GB742@kroah.com>
	 <20051207232105.GO6793@flint.arm.linux.org.uk>
	 <20051208215815.3d001dab.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/05, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Russell,
>
> > On Wed, Dec 07, 2005 at 03:06:15PM -0800, Greg KH wrote:
> > > Ok, that's fine with me.  Russell, any objections?
> >
> > None what so ever - that's mostly what I envisioned with the patch
> > with the _del method.  However, I didn't have an existing user for it.
>
> Do you mean you have the code already? If it is so, could you please
> provide a patch Dmitry and I can give a try to?
>

I have the patch (my version anyway), I will send it out tonight.

> If not, I am willing to give it a try, if you provide some guidance. I
> think I understand that platform_device_del would be the first half of
> platform_device_unregister, but do we then want to rebuild
> platform_device_unregister on top of platform_device_del so as to avoid
> code duplication, or not?
>

Yes, _unregister is changed to be smply call to _del + _put.

--
Dmitry
