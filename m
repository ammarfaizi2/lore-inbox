Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751707AbWFAEdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbWFAEdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 00:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWFAEdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 00:33:12 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:46795 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751707AbWFAEdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 00:33:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=DqxdrTD/vRz/cdyRkxSCsDK7q2OThWdgo8hDWIwUDj2eDJqGmaBSM1B98qzsuuYvS/FPWnfjNr6jsg3k2trTMpL6yE4gAhFP1O91rqyfGpyP0IBOsHkr4VF3kyJcvOLIojayytfCVk0xmBudEiseKx4IldI+lppPYAMtNxFAv3g=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Tony Griffiths'" <tonyg@agile.tv>, <linux-kernel@vger.kernel.org>
Subject: RE: Some socket syscalls fail to return an error on bad file-descriptor# argument
Date: Wed, 31 May 2006 21:33:00 -0700
Message-ID: <003801c68534$7bfdc4e0$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <447E614F.3090905@agile.tv>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcaFLSUnCMgy7nFgSNmAB3ZE0joDcQABzchw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been fixed in 2.6.17. 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Tony 
> Griffiths
> Sent: Wednesday, May 31, 2006 8:39 PM
> To: linux-kernel@vger.kernel.org
> Subject: Some socket syscalls fail to return an error on bad 
> file-descriptor# argument
> 
> Description:
> 
> The sockfd_lookup_light() function does not set the return 
> error status on a particular failure mode when the passed-in 
> fd# is erroneous.
> 
> Environment:
> 
> 2.6.16 kernel with the -mm2 patch-set applied.  Linux 2.6.17 
> kernels are also affected.  Without the fix, a number of 
> tests in LTP fail!  Any program calling one of the syscalls 
> listed below with a bad fd# will not get an error return 
> indicating that the syscall failed.
> 
> Fix:
> 
> The attached patch correctly sets *err = -EBADF if the 
> attempt to map the fd# to a file pointer returns NULL.  The 
> following syscalls are
> affected-
> 
> bind()
> listen()
> accept()
> connect()
> getsockname()
> getpeername()
> setsockopt()
> setsockopt()
> shutdown()
> sendmsg()
> recvmsg()
> 
> 
> 
> 

