Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWG3MuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWG3MuM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 08:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWG3MuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 08:50:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:11172 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751392AbWG3MuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 08:50:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BqdqaTbbyqwKfLc/vSrKy5hVYjVxkKGIv++OU/a5yGvpntUmfEmMVh5sQrXBnEmIzL7O6FrAlm1AhLYOGpVjhyv0pgp0VSFuIAcmU50pgcIbaiHVPe0gyrskA9mgaIpcp1+86VuCJYOdOdLXS1miHuEM/ydEidAhhfrDPtGyaPk=
Message-ID: <41840b750607300550r4337a8e1n1d6f93db1dde46c8@mail.gmail.com>
Date: Sun, 30 Jul 2006 15:50:08 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Generic battery interface
Cc: "Greg KH" <greg@kroah.com>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       "Brown, Len" <len.brown@intel.com>, "Pavel Machek" <pavel@suse.cz>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <20060730114741.GC4898@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
	 <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com>
	 <41840b750607280819t71f55ea7off89aa917421cc33@mail.gmail.com>
	 <d120d5000607280910t458fb6e0hdb81367b888a46db@mail.gmail.com>
	 <20060730085500.GB17759@kroah.com>
	 <41840b750607300252w445974b1udedf1a67114d1580@mail.gmail.com>
	 <20060730114741.GC4898@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Sun, Jul 30, 2006 at 12:52:52PM +0300, Shem Multinymous wrote:
>
> > Coming to think of it, to solve the dev->sys direction, maybe we
> > should have symlinks like the following?
> > /sys/dev/8/0 -> /sys/block/sda
> > /sys/dev/11/0 -> /sys/block/sr0
> > /sys/dev/116/24 -> /sys/class/sound/pcmC0D0c
>
> Since you can have more nodes in /dev with the same node numbers, and
> this actually is useful (for granting more users/groups access to the
> devices in question), this is not going to fly.

No, I'm talking about the *other* direction now: I'm looking at a file
in /dev and I want to find the corresponding sysfs device (if any).

Anyway turns out that sysfs dev numbers are not unique either -- some
devices with major=1 apper twice in sysfs. To give a random example:

$ cat /sys/block/ram8/dev /sys/class/mem/random/dev
1:8
1:8

And these aren't symlinks.
  Shem
