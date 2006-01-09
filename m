Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWAISvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWAISvI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWAISvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:51:08 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:949 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030249AbWAISvH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:51:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=caMijJ/uI0he+7qyDF/IWaEYJJkAnWJR9sqPjhXTt8AqwdPAD6ogeIt0q/+oq3v5UtHDJ1odoYCgl9uUv1wIBkHfAnYBvEzG8PEX0poRuqrAFL6ccgxDO4aZ6lrFl2DX62rykWdGmkNPZvvtEXWVaQ1bjP6/QL0NHekVQtKUkEg=
Message-ID: <86802c440601091051h3752f6ddg6877e0c8aed7a407@mail.gmail.com>
Date: Mon, 9 Jan 2006 10:51:05 -0800
From: Yinghai Lu <yinghai.lu@amd.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [patch 2/2] add x86-64 support for memory hot-add
Cc: Matt Tolentino <metolent@cs.vt.edu>, akpm@osdl.org, discuss@x86-64.org,
       kmannth@us.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <200601091636.21118.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601091521.k09FLU1t022321@ap1.cs.vt.edu>
	 <200601091636.21118.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for Opteron NUMA, need to update
0. stop the DCT on the node that will plug the new DIMM
1. read spd_rom for the added dimm
2. init the ram size and update the memory routing table...
3. init the timing...
4. update relate info in TOM and TOM2, and MTRR, and e820

It looks like we need to get some code about ram init from LinuxBIOS.....

YH
