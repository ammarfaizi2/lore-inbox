Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262054AbSIYSzU>; Wed, 25 Sep 2002 14:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262055AbSIYSzU>; Wed, 25 Sep 2002 14:55:20 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:65446 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262054AbSIYSzS> convert rfc822-to-8bit; Wed, 25 Sep 2002 14:55:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.5.38-mm2 dbench $N times
Date: Wed, 25 Sep 2002 13:51:58 -0500
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <3D9103EB.FC13A744@digeo.com> <297318451.1032908628@[10.10.2.3]>
In-Reply-To: <297318451.1032908628@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209251351.58355.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 September 2002 1:03 am, Martin J. Bligh wrote:
> >> Not sure. This is boot bay SCSI crud, but single-disk FC looks
> >> *worse* for no obvious reason. Multiple disk tests do much better
> >> (about matching the el-scruffo PC numbers above).
> >
> > dbench 16 on that sort of machine is a memory bandwidth test.
> > And a dcache lock exerciser.  It basically doesn't touch the
> > disk.  Something very bad is happening.
>
> Does dbench have any sort of CPU locality between who read it
> into pagecache, and who read it out again? If not, you stand
> 7/8 chance of being on the wrong node, and getting 1/20 of the
> mem bandwidth ....

Pretty sure each dbench child does it's own write/read to only it's own data.  
There is no sharing that I am aware of between the processes.   How about 
running in tmpfs to avoid any disk IO at all?  

Also, what's the policy for home node assignment on fork?  Are all of these 
children getting the same home node assingnment??

-Andrew

