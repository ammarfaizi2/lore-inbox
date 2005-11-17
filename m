Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVKQRCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVKQRCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVKQRCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:02:07 -0500
Received: from citi.umich.edu ([141.211.133.111]:17023 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932423AbVKQRCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:02:06 -0500
Message-ID: <437CB78E.5010707@citi.umich.edu>
Date: Thu, 17 Nov 2005 12:02:06 -0500
From: Chuck Lever <cel@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Organization: Network Appliance, Inc.
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: mmap over nfs leads to excessive system load
References: <20051116223937.28115.qmail@web34112.mail.mud.yahoo.com> <1132182378.8811.93.camel@lade.trondhjem.org>
In-Reply-To: <1132182378.8811.93.camel@lade.trondhjem.org>
Content-Type: multipart/mixed;
 boundary="------------040107040102040606010100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040107040102040606010100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Trond Myklebust wrote:
> I had a quick look at nfs_file_direct_write(), and among other things,
> it would appear that it is not doing any of the usual overflow checks on
> *pos and the count size (see generic_write_checks()). In particular,
> checks are missing against overflow vs. MAX_NON_LFS if O_LARGEFILE is
> not set (and also against overflow vs. s_maxbytes, but that is less
> relevant here).

the architecture is to allow the NFS protocol and server to do these checks.

--------------040107040102040606010100
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------040107040102040606010100--
