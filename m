Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281443AbRKFDXx>; Mon, 5 Nov 2001 22:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281444AbRKFDXn>; Mon, 5 Nov 2001 22:23:43 -0500
Received: from zero.tech9.net ([209.61.188.187]:25103 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281443AbRKFDXh>;
	Mon, 5 Nov 2001 22:23:37 -0500
Subject: Re: [RFC] bootmem for 2.5
From: Robert Love <rml@tech9.net>
To: William Irwin <willir@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011102140207.V31822@w-wli.des.beaverton.ibm.com>
In-Reply-To: <20011102140207.V31822@w-wli.des.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.05.15.31 (Preview Release)
Date: 05 Nov 2001 22:23:45 -0500
Message-Id: <1005017025.897.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-02 at 17:02, William Irwin wrote:
> A number of people have expressed a wish to replace the bitmap-based
> bootmem allocator with one that tracks ranges explicitly. I have
> written such a replacement in order to deal with some of the situations
> I have encountered.
> [...]

The patch is without problem on 2.4.13-ac7.  Free memory increased by
about 100K: free and dmesg both confirm 384292k vs 384196k.  This is a
P3-733 on an i815 with 384MB.  Very nice.

Note that the patch and UP-APIC do not get along.  Some quick debugging
with William found the cause.  APIC does indeed touch bootmem.  The
above is thus obviously with CONFIG_X86_UP_APIC unset.

	Robert Love

