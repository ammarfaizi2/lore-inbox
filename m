Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbSIYXxl>; Wed, 25 Sep 2002 19:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbSIYXxl>; Wed, 25 Sep 2002 19:53:41 -0400
Received: from holomorphy.com ([66.224.33.161]:26018 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261584AbSIYXxk>;
	Wed, 25 Sep 2002 19:53:40 -0400
Date: Wed, 25 Sep 2002 16:57:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.38-mm2 dbench $N times
Message-ID: <20020925235754.GH3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Theurer <habanero@us.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <3D9103EB.FC13A744@digeo.com> <297318451.1032908628@[10.10.2.3]> <200209251351.58355.habanero@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <200209251351.58355.habanero@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 September 2002 1:03 am, Martin J. Bligh wrote:
>> Does dbench have any sort of CPU locality between who read it
>> into pagecache, and who read it out again? If not, you stand
>> 7/8 chance of being on the wrong node, and getting 1/20 of the
>> mem bandwidth ....

On Wed, Sep 25, 2002 at 01:51:58PM -0500, Andrew Theurer wrote:
> Pretty sure each dbench child does it's own write/read to only it's
> own data. There is no sharing that I am aware of between the processes.
> How about running in tmpfs to avoid any disk IO at all?  

tmpfs needs some fixes before it can be used for that. Hugh's working
on it.


Cheers,
Bill
