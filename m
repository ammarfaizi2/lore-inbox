Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbVLWIx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbVLWIx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 03:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbVLWIx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 03:53:59 -0500
Received: from mx5.mailserveren.com ([213.236.237.251]:7829 "EHLO
	mx5.mailserveren.com") by vger.kernel.org with ESMTP
	id S1030465AbVLWIx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 03:53:58 -0500
Subject: Re: Possible Bootloader Optimization in inflate (get rid of 
	unnecessary 32k Window)
From: Hans Kristian Rosbach <hk@isphuset.no>
To: Axel Kittenberger <axel.kittenberger@univie.ac.at>
Cc: Marc Singer <elf@buici.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1386.81.217.14.229.1135278280.squirrel@webmail.univie.ac.at>
References: <200512221352.23393.axel.kernel@kittenberger.net>
	 <20051222173704.GB23411@buici.com>
	 <1167.81.217.14.229.1135275158.squirrel@webmail.univie.ac.at>
	 <20051222183012.GA27353@buici.com>
	 <1386.81.217.14.229.1135278280.squirrel@webmail.univie.ac.at>
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Date: Fri, 23 Dec 2005 09:53:56 +0100
Message-Id: <1135328036.23862.86.camel@linux>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 20:04 +0100, Axel Kittenberger wrote:
> > Right.  And the time to perform that one copy is exactly...?
> >
> > I doubt that it is a significant percentage of the whole operation.
> 
> Well Yes I agree, I guess also it isn't. Its roughly the time you need to
> copy 1 MB memory around. I just noticed that it is in fact after all still
> unneccary and that in fact could be optimized away. As some
> window-management could can be optimized away.
> 
> I would volunteer to take the time to code it, but only if i have a good
> feeling that it would be accepted... if not, well than okay for me also, i
> will do other things :o)

I would think this would be a welcome optimization for embedded
platforms even if not included in mainline. Embedded platforms
often dont have very fast memory, but nevertheless are
required to boot ASAP.

-HK

