Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278663AbRJSVal>; Fri, 19 Oct 2001 17:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278664AbRJSVab>; Fri, 19 Oct 2001 17:30:31 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:19975 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278663AbRJSVaW>; Fri, 19 Oct 2001 17:30:22 -0400
Date: Fri, 19 Oct 2001 17:30:55 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@muc.de, sim@netnation.com, linux-kernel@vger.kernel.org
Subject: Re: Awfully slow /proc/net/tcp, netstat, in.identd in 2.4 (updated)
Message-ID: <20011019173055.G9206@redhat.com>
In-Reply-To: <20011019145750.A22193@zero.firstfloor.org> <20011019085944.A16467@netnation.com> <k23d4fwkv6.fsf@zero.aec.at> <20011019.135924.112609345.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011019.135924.112609345.davem@redhat.com>; from davem@redhat.com on Fri, Oct 19, 2001 at 01:59:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 01:59:24PM -0700, David S. Miller wrote:
> And, for a 640MB ram machine, a 4MB hash table is perfectly
> reasonable.

That isn't wholly true.  A 4MB hash table can never fit in the cache of 
an Athlon, and for one that's being used as a workstation with 1GB of 
ram and maybe 60 connections active on average, that's a huge waste of 
ram, and a guarantee that there will be lots of cache misses which just 
aren't required.  Keep the cache footprint as low as possible -- it 
results in a system that performs better.

		-ben
