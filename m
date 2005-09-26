Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVIZXzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVIZXzP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 19:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVIZXzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 19:55:14 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:15732 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750812AbVIZXzN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 19:55:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ElteF9Y9M74uGiCQuYOXaOhUcaK6fnGpfWWoFZ450YbCoDHUwDReUZctpwI7UzbYryAg/9YGc5dDr8wkDALuiIxmZkg9UAKJXzC+GWicTYMJH8vff+GTpZpSf6O4B+XTZIuKLvYiFQ0qNp943QiyHDVfcLHIZ2VILJuIJtWeEs8=
Date: Tue, 27 Sep 2005 01:55:03 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crazy Idea: Replacing /dev using sysfs over time
Message-Id: <20050927015503.702ca60e.diegocg@gmail.com>
In-Reply-To: <200509261928.20701.shawn.starr@rogers.com>
References: <200509261928.20701.shawn.starr@rogers.com>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 26 Sep 2005 19:28:18 -0400,
Shawn Starr <shawn.starr@rogers.com> escribió:

>         /sys/class/block/
>         `-- sda
>             |-- sda1
>                     | - major
>                     | - minor
>                     | - raw

With this you're adding again all the device naming linux has got ridden of
by removing devfs (it rememebers me to solaris' devfs: They have a
sysfs-like filesystem, except that things in /dev are a symbolic link to a
device file in /devices)

> Do we really need /dev other than for historical/legacy purposes?

If your intention is just to boot kernels and not run userspace on them,
then sure, it's a good idea to get rid of /dev.
