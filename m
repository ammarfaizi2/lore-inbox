Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268791AbTGOP77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268789AbTGOP6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:58:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:51171 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268577AbTGOP6G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:58:06 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Josh Litherland <josh@emperorlinux.com>
Subject: Re: Partitioned loop device..
Date: Tue, 15 Jul 2003 11:04:49 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030715155317.317B461FDE@sade.emperorlinux.com>
In-Reply-To: <20030715155317.317B461FDE@sade.emperorlinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307151104.49455.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 July 2003 10:53, Josh Litherland wrote:
> In article <200307151001.44218.kevcorry@us.ibm.com> you wrote:
> > so there's not much of a reason to add partitioning support to the loop
> > driver itself.
>
> Working with sector images of hard drives?  I use Linux for data
> recovery jobs and it would be very helpful to me to be able to look at
> DOS partitions inside a loopback device.  As it is I must chunk it up
> into seperate files by hand.

Like I said, this exact thing can be done using Device-Mapper and EVMS. No 
need to add new partitioning support to the loop driver.

Generally, EVMS does not look for loop devices when scanning for disks to use, 
but I have a simple patch (to the EVMS tools) that will allow it to recognize 
loop devices. Let me know if you're interested.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

