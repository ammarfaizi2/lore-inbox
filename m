Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbTKTV7R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 16:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbTKTV7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 16:59:17 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:5706 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S264335AbTKTV7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 16:59:10 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Timothy Miller'" <miller@techsource.com>,
       "'Andreas Dilger'" <adilger@clusterfs.com>
Cc: "'Justin Cormack'" <justin@street-vision.com>,
       "'Jesse Pollard'" <jesse@cats-chateau.net>,
       "'linux-kernel mailing list'" <linux-kernel@vger.kernel.org>
Subject: RE: OT: why no file copy() libc/syscall ??
Date: Thu, 20 Nov 2003 13:58:59 -0800
Organization: Cisco Systems
Message-ID: <00dd01c3afb1$8172ea50$d43147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <3FBD328C.1070607@techsource.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andreas Dilger wrote:
> > On Nov 20, 2003  15:44 -0500, Timothy Miller wrote:
> > 
> >>This could be a problem if COW causes you to run out of space when 
> >>writing to the file.
> > 
> > 
> > Not much different than running out of space copying a file.
> 
> It is, though.  If you run out of space copying a file, you 
> know it when you're copying.  Applications don't usually expect to get

> out-of-space errors while overwriting something in the middle of a
file.

It could for journaling filesystem already.

It's not in any spec that writing to the middle of a file would not
cause ENOSPC, is it?

> In effect, your free space and your used space add up to greater than 
> the capacity of the disk.  An application that checks for free space 
> before doing something would be fooled into thinking there is 
> more free space than there really is.  How can an application find out

> in advance that a file that it's about to modify (without appending 
> anything to the end) is going to need more disk space?

