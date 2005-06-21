Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVFUUfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVFUUfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVFUUdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:33:47 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:58153 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262315AbVFUUcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:32:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UmMHZwFjpkrCTAB4IlqBrwspSpsB5m8hZLLrhOi9Y3GlqJIWyTpfiRIgF5s4zeJej+4ROGS4XZjl+jsPsy3XZ1FIlOIvfS7sii33MTEe8RHTWGEgkWJd2QS1aQ+KkfX7+OLqHki8TplNr0A4PQ15KZEeaVo1ihXNOXfgkE7XvuQ=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: e1000 driver works on UP, bt not SMP x86_64 (2.6.7 -2.6.12)
Date: Wed, 22 Jun 2005 00:38:05 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0506191642440.12697@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0506191642440.12697@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506220038.05869.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 June 2005 03:55, David Lang wrote:
> I have some systems with three Intel quad gig-E cards in them that 
> function with the attached UP config, but port 4 of each card doesn't work 
> properly with a SMP kernel (otherwise the same config).
> 
> on a SMP kernel when I do an ifconfig of the fourth port I get the 
> following error
> SIOCSIFFLAGS: Function not implemented
> 
> doing an ifconfig of the interface then looks proper, but no network route 
> is added.
> 
> I first ran into this problem with a 2.6.7 kernel and tried several 
> kernels from there to 2.6.12, all of which showed the same problem on SMP 
> kernels. the problem happens with the driver built-in and as a module.
> 
> the systems are dual Opteron 246, 2G ram MPT fusion SCSI drives.

I've filed a bug at kernel bugzilla, so your report won't be lost.
See http://bugzilla.kernel.org/show_bug.cgi?id=4774
