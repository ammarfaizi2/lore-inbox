Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWCMDSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWCMDSx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 22:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWCMDSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 22:18:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11149 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750716AbWCMDSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 22:18:53 -0500
Date: Sun, 12 Mar 2006 22:18:49 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@redline.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm1
In-Reply-To: <20060312031036.3a382581.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0603122213510.7935-100000@redline.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2006, Andrew Morton wrote:

>   Author: Catherine Zhang <cxzhang@watson.ibm.com>
>   Date:   Fri Mar 10 00:34:15 2006 -0800
> 
>     [SECURITY]: TCP/UDP getpeersec
>     
>     This patch implements an application of the LSM-IPSec networking
>     controls whereby an application can determine the label of the
>     security association its TCP or UDP sockets are currently connected to
>     via getsockopt and the auxiliary data mechanism of recvmsg.
> 
>   Which I am sure is very good.

Think of it as an extension of the existing Linux SO_PASSCRED for Unix
sockets, which currently allow you to authenticate the uid/gid/pid of a
local peer process with which you are communicating.  But now extended to
other security information such as an SELinux security context, and for
non-local processes, protected and authenticated via IPsec.



- James
-- 
James Morris
<jmorris@redhat.com>


