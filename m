Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVDQXtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVDQXtO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 19:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVDQXtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 19:49:14 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:53834 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261567AbVDQXsx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 19:48:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ap4yLceMcfZpZNSULtE2mC2psV1f2kYTgmeQ7ru8EY2yQ2pvEZtvAyjyVEXA7h7HagJUtgLjNCtphiZ5s9YqJYZZF4SK6Tb38SRzDEJhSuYT07mrTl+lo8FUPj1l3RllbHewvOKX+jhdd0YWmr34EW8tcAHIO5fQyji4qnDCiU4=
Message-ID: <4ae3c140504171648d587669@mail.gmail.com>
Date: Sun, 17 Apr 2005 19:48:50 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: Bernd Eckenfels <ecki@lina.inka.de>
Subject: Re: Why Ext2/3 needs immutable attribute?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1DNFkJ-0006SI-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140504170912b36e9b1@mail.gmail.com>
	 <E1DNFkJ-0006SI-00@calista.eckenfels.6bone.ka-ip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can certainly harden the system, but sometime the vulnerability in
kernel is hard to detect and protect. For example, the brk()
vulnerablitiy found in Linux kernel. All the security mechanisms you
mentioned have to rely on a healthy kernel. Unfortunately, the kernel
itself could be compromised too. Although it could be very difficult,
thereotically speaking,  any kernel level protection, including
SELinux, could be disabled after the kernel is compromised. Am I
missing some points here?


On 4/17/05, Bernd Eckenfels <ecki@lina.inka.de> wrote:
> In article <4ae3c140504170912b36e9b1@mail.gmail.com> you wrote:
> > Yes. I know,  with immutable,  even root cannot modify sensitive
> > files. What I am curious is if an intruder has root access, he may
> > have many ways to turn off the immutable protection and modify files.
> 
> If you secure your system correctly (i.e make /dev/*mem imutable, disalow
> module loading, restrict io... (and I admit it is quite complicated to find
> all holes and secure it correctly without additional ptches like SELinux))
> then even root cant gt arround immutable or append only (without rebooting).
> 
> Greetings
> Bernd
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
