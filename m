Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbVGNU3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVGNU3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbVGNUG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:06:28 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:63645 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S263122AbVGNUF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:05:56 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: FyD <fyd@u-picardie.fr>
Subject: Re: Problem with kernel 2.6.11
Date: Thu, 14 Jul 2005 21:06:06 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <1121369685.42d6be556505f@webmail.u-picardie.fr>
In-Reply-To: <1121369685.42d6be556505f@webmail.u-picardie.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507142106.06682.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 Jul 2005 20:34, FyD wrote:
> Dear All,
>
> I have a problem with a program named Gaussian (http://www.gaussian.com)
> (versions g98 or g03) and FC 4.0 (default kernel 2.6.11): I am used to take
> Gaussian binaries compiled on the RedHat 9.0 version, and used them on FC
> 2.0 or FC 3.0. If I try to do so, on FC 4.0. (with the default kernel)
> Gaussian stops (both g98 and g03 versions) with the following error
> message:
>
> [fyd@localhost ~]$ g98 < toto-g98.com> toto-g98.log
> [fyd@localhost ~]$ g03 < toto-g03.com> toto-g03.log
> Erroneous write during file extend. write 208 instead of 4096
> Probably out of disk space.
> Write error in NtrExt1: No such file or directory
>
> And obviously, I do _not_ have any problem of space and no NFS server on my
> machine...
>
> Now if I compile and use the kernel 2.6.12, this message dispears and the
> program Gaussian g98 works fine, but I still have problems with the version
> g03 which stops without providing any message...
>
> From my tests, it seems to be a problem relative to the kernel. Being not a
> programmer, it is difficult for me to imagine the problem, and even to
> describe it...

Install "strace", then run the programs like:

strace g98 < toto-g98.com> toto-g98.log

You'll be able to see what syscalls fail and their decoded return values. This 
is extremely useful for determining how a binary application is interacting 
with libc and, inevitably, the kernel.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
