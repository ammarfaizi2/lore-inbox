Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267320AbTABXnw>; Thu, 2 Jan 2003 18:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbTABXnv>; Thu, 2 Jan 2003 18:43:51 -0500
Received: from holomorphy.com ([66.224.33.161]:41158 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267320AbTABXnv>;
	Thu, 2 Jan 2003 18:43:51 -0500
Date: Thu, 2 Jan 2003 15:51:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Questton about Zone Allocation 2.4.X
Message-ID: <20030102235147.GS9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
References: <20030102175517.A21471@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102175517.A21471@vger.timpanogas.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 05:55:17PM -0700, Jeff V. Merkey wrote:
> I have a system in the lab with 4GB of physical and the system can see all 
> the memory, however, calls to get_free_pages() will only allocate up to 1GB
> of this memory before returning an out of memory condition.  I have reviewed
> Ingo's changes and enhancements with the zone allocator and it certainly 
> looks like this code has the smarts to balance the contiguous free pages
> on the zone allocation lists.  I need to be able to get more than 1GB to 
> pin for a particular application.  Where do I need to adjust the tuning
> to allow 2.4.X kernels to allocate mote than 1GB from the physical pages
> list?
> Any help would be appreciated.
> Thanks
> Jeff Merkey
> Network Associates

__get_free_pages() allocates from lowmem (i.e. 0-4GB) only.
Allocate from highmem instead.


Bill
