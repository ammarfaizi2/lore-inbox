Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267763AbUHZHwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267763AbUHZHwv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 03:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267766AbUHZHwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 03:52:51 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:20962 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267763AbUHZHwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 03:52:37 -0400
Message-ID: <412D96C4.3030302@namesys.com>
Date: Thu, 26 Aug 2004 00:52:36 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Waychison <Michael.Waychison@Sun.COM>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Tim Hockin <thockin@hockin.org>,
       LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       George Beshers <gbeshers@comcast.net>
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant
 architect in the USA for Phase I of a DARPA funded linux kernel project
References: <410D96DC.1060405@namesys.com> <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com> <20040825205618.GA7992@hockin.org> <30958D95-F6ED-11D8-A7C9-000393ACC76E@mac.com> <412D2BD2.2090408@sun.com>
In-Reply-To: <412D2BD2.2090408@sun.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:

>
>
> If I understand what Hans is looking to get done, he's asking for
> someone to architect a system where any given process can be restricted
> to seeing/accessing a subset of the namespace (in the sense of "a tree
> of directories/files").  Eg: process Foo is allowed access to write to
> /etc/group, but _not_ allowed access to /etc/shadow, under any
> circumstances && Foo will be run as root.  Hell, maybe Foo is never able
> to even _see_ /etc/shadow (making it a true shadow file :).

You are correct, you cannot even see /etc/shadow.

The term mask may be more communicative than view.  We are starting to 
use the term mask.

>
> Hans, correct me if I misunderstood.
>
> [*] Somebody really should s/struct namespace/struct mounttable/g (or
> even mounttree) on the kernel sources.  'Namespace' isn't very
> descriptive and it leads to confusion :(
>
> --
> Mike Waychison
> Sun Microsystems, Inc.
> 1 (650) 352-5299 voice
> 1 (416) 202-8336 voice
> http://www.sun.com
>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> NOTICE:  The opinions expressed in this email are held by me,
> and may not represent the views of Sun Microsystems, Inc.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

