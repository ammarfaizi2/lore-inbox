Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317361AbSGVTES>; Mon, 22 Jul 2002 15:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317718AbSGVTES>; Mon, 22 Jul 2002 15:04:18 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:56327 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317361AbSGVTER>; Mon, 22 Jul 2002 15:04:17 -0400
Date: Mon, 22 Jul 2002 20:07:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ben Rafanello <benr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020722200725.A10041@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ben Rafanello <benr@us.ibm.com>, linux-kernel@vger.kernel.org
References: <OF493E1C65.D443AFFF-ON85256BFE.005D57E7@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF493E1C65.D443AFFF-ON85256BFE.005D57E7@pok.ibm.com>; from benr@us.ibm.com on Mon, Jul 22, 2002 at 01:31:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 01:31:11PM -0500, Ben Rafanello wrote:
> I believe you are referring to Device Mapper, which could, in theory,
> handle the AIX metadata layout.  However, AFAIK, there are no tools
> currently available or under development for Device Mapper to make
> this happen. 

A few steps drom from IBM marketing to the developers:

On Fri, Feb 01, 2002 at 03:59:06PM -0600, Kevin Corry wrote:
> I have been thinking about this today and looking over some of the 
> device-mapper interfaces. I will agree that, in concept, EVMS could be 
> modified to use device-mapper for I/O remapping. However, as things stand 
> today, I don't think the transition would be easy.
> 
> As I'm trying to envision it, the EVMS runtime would become a "volume 
> recognition" framework (see tanget below). Every current EVMS plugin would 
> then probe all available devices and communicate the necessary volume 

...


> The
> does not appear to be anything in either LVM2 or Device Mapper for
> manipulating partition tables and resizing partitions.  User space tools
> could be written to work with Device Mapper to make this happen, but such
> tools do not yet exist, AFAIK.

And EVMS sucks in trucloads of fs code that already exists in userspace
instead of using e.g. the parted library that can easily be linked to the
LVM2 tools.

EVMS is not about integration but sucking in tons of code into a big IBM
project.  A little cooperation would help instead of doing everything
from scratch and ignoring existing functionality.
