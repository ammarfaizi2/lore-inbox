Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWG3LsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWG3LsL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWG3LsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:48:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:58458 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932288AbWG3LsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:48:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GohT5SrNbFxH+1ATLUGZxRguk9NIrAnkVXqPEz6gasXcR9EfohbMi9XtRHGP+WCgMzHU5SH0gWS1qWqh2cqyS7vHn0HngJpKbM+VKHDSSZ8Q3PmaQnAdbpWu5Jqv9EdPNptsZFct0GmjB3n41J5jKbotyKErE4k6Q3hsm1Ka2RE=
Message-ID: <41840b750607300448u353a3276o8c30d7d880da6329@mail.gmail.com>
Date: Sun, 30 Jul 2006 14:48:07 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Generic battery interface
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Pavel Machek" <pavel@suse.cz>,
       "Brown, Len" <len.brown@intel.com>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <200607300835.k6U8ZvSB016669@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz>
	 <20060728134307.GD29217@suse.cz>
	 <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com>
	 <200607281557.k6SFvn09022794@turing-police.cc.vt.edu>
	 <41840b750607281510j2c5babf8x9fac51fe6910aeda@mail.gmail.com>
	 <200607282314.k6SNESSg019274@turing-police.cc.vt.edu>
	 <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com>
	 <200607300835.k6U8ZvSB016669@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> If the program says '100ms' because it knows it will need to do a GUI update
> then, and you block it for 5 seconds because that's when the next value
> update happens, the user is stuck looking at their gkrellm or whatever not
> doing anything at all for 4.9 seconds....
>
> This almost forces the use of multiple threads if the program wants to do
> its own timer management.

Please read my detailed proposal, posted (and resivsed) later.

The program is not blocked by the new ioctl, it still does a poll() or
select() and can provide a timeout, as usual. The only trick is that
the poll() won't return with an input-ready event until the
appropriate time.

  Shem
