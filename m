Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbSLVUsU>; Sun, 22 Dec 2002 15:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSLVUsU>; Sun, 22 Dec 2002 15:48:20 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:19683
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265361AbSLVUsT>; Sun, 22 Dec 2002 15:48:19 -0500
Message-ID: <3E062712.80906@redhat.com>
Date: Sun, 22 Dec 2002 12:56:50 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "James H. Cloos Jr." <cloos@jhcloos.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212221132370.2692-100000@home.transmeta.com>	<3E0617A9.90405@redhat.com> <m3adixvkvb.fsf@lugabout.jhcloos.org>
In-Reply-To: <m3adixvkvb.fsf@lugabout.jhcloos.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James H. Cloos Jr. wrote:

> I'd tend to prefer an LD_PRELOAD-able dso that just set up %gs and had
> entries for each of the foo(2) over a full glibc rpm.

This is not possible.  The infrastructure is set up in the dynamic
linker.  Read the mail with the references to the NPTL mailing list.
The second referenced mail contains a recipe for building glibc and then
using it in-place.  This is not possible with binary RPMs in the way we
build them.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

