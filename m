Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUAXBpt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 20:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266670AbUAXBpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 20:45:49 -0500
Received: from hera.kernel.org ([63.209.29.2]:3813 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S265237AbUAXBps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 20:45:48 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Userland headers available
Date: Sat, 24 Jan 2004 01:38:06 +0000 (UTC)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <busi9u$fd7$1@terminus.zytor.com>
References: <200401231907.17802.mmazur@kernel.pl> <20040123184755.GA2138@nevyn.them.org> <401172D8.8040507@nortelnetworks.com> <4011788D.3070606@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1074908286 15783 66.80.2.163 (24 Jan 2004 01:38:06 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 24 Jan 2004 01:38:06 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: hpa@smyrno.(none) (H. Peter Anvin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4011788D.3070606@nortelnetworks.com>
By author:    Chris Friesen <cfriesen@nortelnetworks.com>
In newsgroup: linux.dev.kernel
>
> Friesen, Christopher [CAR:7Q28:EXCH] wrote:
> 
> > The obvious way is to have the kernel headers include the userland
> > headers, then everything below that be wrapped in "#ifdef __KERNEL__". 
> > Userland then includes the normal kernel headers, but only gets the 
> > userland-safe ones.
> 
> I just realized this wasn't clear.  I envision a new set of headers in 
> the kernel that are clean to export to userland.  The current headers 
> then include the appropriate userland-clean ones, and everything below 
> that is kernel only.
> 
> This lets the kernel maintain the userland-clean headers explicitly, and 
> we don't have the work of cleaning them up for glibc.
> 

We've referred to this for quite a while as the "ABI header project";
it's been targetted for 2.7, since it missed the 2.6 freeze.

We have set up a mailing list at:

	http://zytor.com/mailman/listinfo/linuxabi

The goal is to get a formal exportable version of the kernel ABI that
user-space libraries can use.

	-hpa
