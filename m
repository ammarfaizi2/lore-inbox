Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUKCM4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUKCM4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 07:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbUKCM4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 07:56:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45456 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261582AbUKCM4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 07:56:12 -0500
Message-ID: <4188D55D.7000200@redhat.com>
Date: Wed, 03 Nov 2004 07:55:57 -0500
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Warnock <timoid@getonit.net.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: ipv4 arp and linux
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA4+E3P43380+sBshf1RHa98KAAAAQAAAADJ+ICBUnRkOc9W13U4B0WAEAAAAA@getonit.net.au>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA4+E3P43380+sBshf1RHa98KAAAAQAAAADJ+ICBUnRkOc9W13U4B0WAEAAAAA@getonit.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Warnock wrote:
> What arp packet size does a linux 2.4 series kernel use? How would it be
> made bigger?
> 
64 bytes is the minimum packet size of an ethernet frame (which includes 
the CRC).  ARP requests don't take up that much space so the kernel pads 
them out to be large enough.  A tcpdump will show you exactly how it looks.

> I'm having a problem where a cisco switch is ignoring me because (according
> to the guys who operate it) the arp spec for 802.3 is 64 bytes and im not
> doing that.
> 
802.3 stipulates 64 bytes for all ethernet frames.  If you have a 
program that is somehow sending frames smaller than that, yes, you (or 
something) is broken.  How exactly are you sending frames that you think 
are too small?

Neil
> Im not subscribed to the list, so if I could be cc'd I'd appreciate it.
> 
> Hope someone can help me, and thanks for taking the time to read this.
> 
> Tim
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
