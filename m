Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUDOXFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 19:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUDOXFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 19:05:16 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:42390 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261862AbUDOXFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 19:05:12 -0400
Message-ID: <407F151F.4020703@nortelnetworks.com>
Date: Thu, 15 Apr 2004 19:05:03 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Fabian Frederick <Fabian.Frederick@skynet.be>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: NFS proc entry
References: <1082060754.9112.2.camel@bluerhyme.real3>	 <1082065633.7141.52.camel@lade.trondhjem.org>	 <407F06BD.3010905@nortelnetworks.com> <1082068356.7141.70.camel@lade.trondhjem.org>
In-Reply-To: <1082068356.7141.70.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> På to , 15/04/2004 klokka 15:03, skreiv Chris Friesen:
> 
>>However, with the current setup filesystem monitoring deamons must fork 
>>off a child for each mount, since statfs() can block for many seconds if 
>>the server has gone away.

> So exactly how would moving that monitoring into the kernel change the
> parameters of the above problem?

I guess I was thinking that if the kernel knew the status of the mounts, 
it could speed things up for userspace apps that don't properly handle 
network filesystems.  Probably not practical though.

We had an interesting time converting some apps that were originally 
using a ramdisk to run with NFS-mounted files.  Since reading from the 
ramdisk never blocked for significant amounts of time, some of the apps 
didn't design for IO delay and behaved poorly the first time we pulled 
the links to the NFS server.

Chris
