Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268149AbUH1ECM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268149AbUH1ECM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 00:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbUH1ECM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 00:02:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2966 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268149AbUH1ECK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 00:02:10 -0400
Date: Fri, 27 Aug 2004 20:57:24 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
       jgarzik@redhat.com
Subject: Re: [usb-storage] drivers/block/ub.c #6
Message-Id: <20040827205724.64a3c99f@lembas.zaitcev.lan>
In-Reply-To: <1093645959.8006.219.camel@patlinux.iomegacorp.com>
References: <20040730035120.30abd121@lembas.zaitcev.lan>
	<1093640531.8006.68.
	camel@patlinux.iomegacorp.com>
	<1093645959.8006.219.camel@patlinux.iomegacorp.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Aug 2004 16:32:39 -0600
Pat LaVarre <p.lavarre@ieee.org> wrote:

> Looks to me like we have ub.ko taking over just x 08 06 50, rather than
> all of the x 08 (06|05|02) 50 = bInterfaceClass ...SubClass ...Protocol
> considered generic by MSFT?
> 
> http://www.microsoft.com/whdc/device/storage/usbfaq.mspx
> agrees Flash should be x 08 06 50 but gives no clear guidance to the
> rest of us.
> 
> I remember we invented x 08 06 50 to be the one tuple to rule them all,
> to move the determination of PDT (peripheral device type) etc. back into
> op x12 "INQUIRY" where it belongs, ...

I'll look at non-bulk once we have something useable by common folks
and Fedora ships ub, but not before. All my devices use Bulk. But also,
UFI has to come first. Only then, perhaps, I'll look at CB and CBI.

> Of course the world may yet contain advocates of connecting HDD/FDD as
> bInterfaceSubClass = x05 "SFF 8070" = Compaq LS-120 or connecting DVD/CD
> as x02 "SFF 8020" = read-only CD.

I don't have any plans for 8070 and 8020i. I promise to look at patches
if someone submits any. However, in my experience, 8070 devices are fickle.
They may be better off left to usb-storage forever, with its richer
infrastructure.

-- Pete
