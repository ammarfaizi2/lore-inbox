Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759256AbWK3QYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759256AbWK3QYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 11:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759257AbWK3QYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 11:24:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:59673 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1759256AbWK3QY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 11:24:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aMxazSe6Ku1EuoQK1tHfadbZUnCIudIXYPNp9mhJIifhghmiGyWrKv0OnZO3Sv28vq2EGlceAJMw48AIfE1rJh/9m9FlxI6KfPv/5g8RoSMB3QPgGwG2tPrgPGsE7wCuhOGWJGk2qprfphXl3eTGWGo+wBSKwGXuzxu73rbOyRY=
Message-ID: <a4e6962a0611300824qdfa43cbja783da86fe6eb5cf@mail.gmail.com>
Date: Thu, 30 Nov 2006 10:24:27 -0600
From: "Eric Van Hensbergen" <ericvh@gmail.com>
To: "device-mapper development" <dm-devel@redhat.com>
Subject: Re: [dm-devel] [RFC][PATCH] dm-cache: block level disk cache target for device mapper
Cc: "Eric Van Hensbergen" <ericvh@hera.kernel.org>, ming@acis.ufl.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200611301232.57966.jens.wilke@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611271826.kARIQYRi032717@hera.kernel.org>
	 <200611301232.57966.jens.wilke@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/06, Jens Wilke <jens.wilke@de.ibm.com> wrote:
> On Monday 27 November 2006 19:26, Eric Van Hensbergen wrote:
>
> If this is intended to speed up remote disks, is it possible that the cache content
> can be paged out on local disks in low-mem situations?
>

The main intent was to use local disks as cache to offload centralized
remote disks.  The logic was that most systems have local disks, if
only for swap -- so why not use them as a cache to help offload
centralized storage.  While the in-memory page cache works perfectly
fine in certain situations -- we were dealing with workloads in which
the in-memory page-cache wasn't sufficient to hold all the data.

There are also some additional possibilities we've thought through and
have been playing with including allowing the local disk cache to be
persistent across reboots (with varying validation schemes).

             -eric
