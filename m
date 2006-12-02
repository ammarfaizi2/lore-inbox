Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759397AbWLBGjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759397AbWLBGjF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 01:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759398AbWLBGjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 01:39:05 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:14545 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1759397AbWLBGjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 01:39:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aQS1P79kKrR+x7hL8dXsWJI/y8B1+etCEi4maERcz/hcVQMjXsGIFwOa0ovqVtz+6vUohqZC7Xd32AuAa9dIEDgUJqOHm9LBJvWQABSXwTgOB6rhPQOgagl2pG/CkvP37X6Xg6h0U5+lBypukUL+cJ6/uM+aJQb+iQNKJsZp5KA=
Message-ID: <a2705a960612012239j697f2799t27bec643f33c9e12@mail.gmail.com>
Date: Fri, 1 Dec 2006 22:39:01 -0800
From: mariusn@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Linux portability bugs
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please include me in CCs - I am not subscribed to the list.]

Hi guys,

I am a graduate student at University of Washington, building a tool
automatically discover portability bugs in system-level code written
in C. My definition of "portability" is at the data layout level,
accounting for differences in alignment, padding, and generally layout
policies on various platforms. E.g., one might perform a pointer cast
that only works as intended when doubles are 4-byte aligned, which is
the case with gcc/ia-32 (default options) but not with gcc/sparc (due
to sparc's limited support for accessing doubles on non-8-byte
boundaries).

I am looking for advice on how/where to look for these kinds of bugs
in the kernel and related software. This (dated) document
(http://netwinder.osuosl.org/users/b/brianbr/public_html/alignment.html
) describes exactly these sorts of issues in the context of Linux/ARM
and mentions things like the kernel, binutils, cpio, X11, Orbit, as
sources of these sorts of bugs. I am having a bit of a hard time
locating change logs and otherwise related information on where these
bugs occurred, patches that addressed them, etc.

Any pointers or discussion whatsoever about known/fixed bugs, and also
any hunches on where these sorts of portability bugs might lay
dormant, would be much appreciated. I am committed to contributing
back anything I find in my research - in the form of patches or bug
reports.

Thank you!

-Marius
