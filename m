Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWBHVqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWBHVqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWBHVqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:46:20 -0500
Received: from mail.gmx.net ([213.165.64.21]:33713 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751144AbWBHVqU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:46:20 -0500
X-Authenticated: #19095397
From: Bernd Schubert <bernd-schubert@gmx.de>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: 2.6.15 Bug? New security model?
Date: Wed, 8 Feb 2006 22:46:15 +0100
User-Agent: KMail/1.8.3
Cc: John M Flinchbaugh <john@hjsoft.com>, reiserfs-list@namesys.com,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org
References: <200602080212.27896.bernd-schubert@gmx.de> <200602081314.59639.bernd-schubert@gmx.de> <20060208205033.GB22771@shell0.pdx.osdl.net>
In-Reply-To: <20060208205033.GB22771@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602082246.15613.bernd-schubert@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > After the problem came up, I already suspected something like this and
> > therefore already had the kernel recompiled without xattr support, so I
> > don't know why lsattr shows something for 2.6.15 and nothing for 2.6.13.
>
> attrs != xattrs

Ah, I thought its the same.

>
> Couple of things:
>
> 1) what does 'grep attrs_cleared /proc/fs/reiserfs/on-disk-super' show?

Er, you mean /proc/fs/reiserfs/{partition}/on-disk-super?

bernd@bathl ~>grep attrs_cleared /proc/fs/reiserfs/hda6/on-disk-super
flags:  1[attrs_cleared]


>
> 2) does mount -o attrs ... make a difference?

Yes, 2.6.13 now makes the same trouble. No difference with 2.6.15.3. 
I played with mount -o noattrs, this makes no difference with 2.6.13, but has 
some effects to 2.6.15.3. Creating files in /var/run is possible again, 
lsattr gives "lsattr: Inappropriate ioctl for device While reading flags 
on /var/run", but deleting files in /var/run is still impossible (still 
rather bad for the init-scripts).


Thanks,
	Bernd

-- 
Bernd Schubert
PCI / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg

