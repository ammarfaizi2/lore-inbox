Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262711AbTCJEaZ>; Sun, 9 Mar 2003 23:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbTCJEaZ>; Sun, 9 Mar 2003 23:30:25 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:2441
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S262711AbTCJEaX>; Sun, 9 Mar 2003 23:30:23 -0500
From: scott thomason <scott-kernel@thomasons.org>
Reply-To: scott-kernel@thomasons.org
To: joe briggs <jbriggs@briggsmedia.com>
Subject: Re: patching the kernel
Date: Sun, 9 Mar 2003 22:41:03 -0600
User-Agent: KMail/1.5
References: <200303091711.21652.jbriggs@briggsmedia.com>
In-Reply-To: <200303091711.21652.jbriggs@briggsmedia.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303092241.03335.scott-kernel@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 March 2003 04:11 pm, joe briggs wrote:
> My apologies for this question that is so basic to all of you,
> but can any of you please point me toward a howto or
> instructions for exactly how to 'patch a kernel'?  For
> example, at kernel.org, the latest stable kernel is 2.4.20,
> and is actually a patch.  I currently use 2.4.19 under Debian
> and routinely rebuild & install it no problem.  If I download
> a kernel 'patch', do I apply it to the entire directory, or
> the compiled kernel, etc.?  Thanks so much.

I usually use these patch commands, as they make finding any 
errors so much easier:

bunzip patchfile.bz2 ## or...
gunzip patchfile.gz

cd linux-2.4.x
## To see if the patch is actually going to work
patch -p1 --batch --quiet --dry-run < ../patchfile
## To actually apply the patch
patch -p1 --batch --quiet < ../patchfile

---scott
