Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285559AbRLNWbM>; Fri, 14 Dec 2001 17:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285556AbRLNWa7>; Fri, 14 Dec 2001 17:30:59 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:20547 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285559AbRLNWaq>; Fri, 14 Dec 2001 17:30:46 -0500
Date: Fri, 14 Dec 2001 17:30:45 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: zap_page_range in a module
Message-ID: <20011214173045.C26535@redhat.com>
In-Reply-To: <C8C7DD4157F2D411AC7000A0C96B1522016C37D4@fmsmsx58.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <C8C7DD4157F2D411AC7000A0C96B1522016C37D4@fmsmsx58.fm.intel.com>; from matthew.j.sottek@intel.com on Fri, Dec 14, 2001 at 01:26:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2001 at 01:26:29PM -0800, Sottek, Matthew J wrote:
> currently can only work when compiled into the kernel because I need 
> zap_page_rage(). Is there an acceptable way for me to get equivalent
> functionality in a module so that this will be more useful to the
> general public?

The vm does zap_page_range for you if you're implementing an mmap operation, 
otherwise vmalloc/vfree/vremap will take care of the details for you.  How 
is your code using zap_page_range?  It really shouldn't be.

		-ben
