Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbUKEDIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbUKEDIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 22:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUKEDIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 22:08:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31660 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262577AbUKEDIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 22:08:12 -0500
Message-ID: <418AEE8D.4010007@pobox.com>
Date: Thu, 04 Nov 2004 22:07:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Jakob Oestergaard <jakob@unthought.net>, Brad Campbell <brad@wasp.net.au>,
       lkml <linux-kernel@vger.kernel.org>,
       "Dr. Bruce Fields" <bfields@fieldses.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
References: <41877751.502@wasp.net.au>	 <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com>	 <20041102200925.GA12752@unthought.net>  <418AE9DD.3010008@pobox.com> <1099623541.25951.8.camel@lade.trondhjem.org>
In-Reply-To: <1099623541.25951.8.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> to den 04.11.2004 Klokka 21:47 (-0500) skreiv Jeff Garzik:
> 
>>>Does running an 'ls' on the server in the exported directory that is
>>>stale on the client resolve the problem (temporarily)?
>>
>>Yes.
> 
> 
> This still looks very much like a server issue to me. Could someone who
> is seeing the bug try to capture an instance of the ESTALE error going
> across the wire, and then do a fresh lookup of the same file from an
> "ls" call. I'd like to check how the stale filehandle differs from the
> freshly looked up one...
> 
> Please use "tcpdump -s 9000 -w /tmp/binary.pcap port 2049 and host
> my.servers.name" for the actual capture.

Will do.

FWIW my server is running 2.6.9-final.  Client mount options in fstab 
are "defaults,tcp" and server options are (rw,no_root_squash,async).

	Jeff



