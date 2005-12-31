Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVLaBk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVLaBk4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 20:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVLaBk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 20:40:56 -0500
Received: from mx.pathscale.com ([64.160.42.68]:31400 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932082AbVLaBkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 20:40:55 -0500
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051231001051.GB20314@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <20051230080002.GA7438@kroah.com>
	 <1135984304.13318.50.camel@serpentine.pathscale.com>
	 <20051231001051.GB20314@kroah.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 30 Dec 2005 17:40:50 -0800
Message-Id: <1135993250.13318.94.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 16:10 -0800, Greg KH wrote:

> But we (the kernel community), don't really accept that as a valid
> reason to accept this kind of code, sorry.

Fair enough.  I'd like some guidance in that case.  Some of our ioctls
access the hardware more or less directly, while others do things like
read or reset counters.

Which of these kinds of operations are appropriate to retain as ioctls,
in your eyes, and which are best converted to sysfs or configfs
alternatives?

As an example, take a look at ipath_sma_ioctl.  It seems to me that
receiving or sending subnet management packets ought to remain as
ioctls, while getting port or node data could be turned into sysfs
attributes.  Lane identification could live in configfs.  If you think
otherwise, please let me know what's more appropriate.

The less blind I am in doing these conversions, the fewer rounds we'll
have to go in reviewing humongous driver submission patches :-)

Thanks,

	<b

