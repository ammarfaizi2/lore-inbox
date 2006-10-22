Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWJVRTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWJVRTT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 13:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWJVRTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 13:19:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:29403 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751311AbWJVRTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 13:19:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QIfGV4cR1VG4+sfIi6ERVvYGw1/6enHq4VPfXPNKPWfPDCfEBcU+EsdQ3ERe+1bzcEazKhvTy7dgxi3AesWQIBLMiSfiQlZW4pOY4/YCV4aBVf7zFfwgSwgLkZwmwTJUFzeG/qJ4nlgkEvmRFYLcalTNGgtyf3A7UibrwYPdG4Q=
Message-ID: <b1bc6a000610221019i47283722g3b8f4a79918c4825@mail.gmail.com>
Date: Sun, 22 Oct 2006 10:19:16 -0700
From: "adam radford" <aradford@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 3Ware delayed device mounting errors with newer 9500 series adapters
Cc: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linuxraid@amcc.com,
       linux-scsi@vger.kernel.org
In-Reply-To: <20061021233904.c2f40a5f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <453A52CE.80605@wolfmountaingroup.com>
	 <20061021233904.c2f40a5f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

Can you reproduce with 2.6.18.1?  ES4 contains a custom 3ware driver.

Also, you have included no error output with this email whatsoever.  Can
you go to a virtual console during your ES4 install, run 'dmesg', and see if
the errors are in there, or if they are a part of the ES4 anaconda installer?

/dev/sdb, etc. having delayed appearances sounds like it is udev related.

Are you running the latest firmware?  Do your controllers older than 60 days
have different firmware?

I will try to reproduce this.

-Adam

On 10/21/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sat, 21 Oct 2006 11:03:10 -0600
> "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com> wrote:
>
> >
> > Adam,
> >
> > We have been getting 3Ware 9500 series adapters in the past 60 days
> > which exhibit a delayed behavior during mounting of FS from
> > /etc/fstab.   The adapters older than this do not exhibit this behavior.
> >
> > During bootup, if the driver is compiled as a module rather than in
> > kernel, mount points such as /var in fstab fail to detect the devices
> > until the system fully boots, at which point the /dev/sdb etc. devices
> > showup.  It happens on both ATA cabled drives and drives
> > cabled with multi-lane controller backplanes.
> >
> > The problem is easy to reproduce.  Install ES4, point the /var directory
> > during install to one of the array devices in disk druid, and after
> > the install completes, /var/ will not mount during bootup and all sorts
> > of errors stream off the screen.  I can reproduce the problem
> > with several systems in our labs and upon investigating the adapter
> > revisions, I find that adapters ordered in the past 60 days exhibit
> > the problem.   Compiling the driver in kernel gets around the problem,
> > indicating its timing related.
> >
>
> cc's added.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
