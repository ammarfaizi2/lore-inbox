Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319539AbSH3Kkv>; Fri, 30 Aug 2002 06:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319540AbSH3Kkv>; Fri, 30 Aug 2002 06:40:51 -0400
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:45305 "HELO
	ip68-4-77-172.oc.oc.cox.net") by vger.kernel.org with SMTP
	id <S319539AbSH3Kku>; Fri, 30 Aug 2002 06:40:50 -0400
Date: Fri, 30 Aug 2002 03:45:14 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Mat Harris <mat.harris@genestate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-3 on rh 7.1?
Message-ID: <20020830104514.GA2165@ip68-4-77-172.oc.oc.cox.net>
References: <20020830083233.GA9196@genestate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830083233.GA9196@genestate.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 09:32:33AM +0100, Mat Harris wrote:
> silly question compared to all you gurus on the list, but it needs to be
> asked. I need to fun freeswan (secure wan) between sever a redhat
> servers. the only patched kernel i am permitted to use is the rpm for
> ipsec enables 2.4.18-3. will this kernel work on redhat 7.1, or will it
> fall over at the first opportunity?

I've never done IPSec, but plain use of 2.4.18-3 does work with Red Hat
7.1. Note that you'll need to either satisfy the dependencies by
upgrading some packages from Red Hat 7.3, or use --nodeps. Both work in
my experiences.

However, note that:
+ 2.4.18-3 has a data corruption bug with ext3 on SMP systems, fixed in
  2.4.18-4.
+ 2.4.18-4 (and -3) has weird NFS problems which are fixed in 2.4.18-5
+ 2.4.18-[345] have security problems which are fixed in 2.4.18-10
  (By the way, does anyone know if new 2.4.9-xx or 2.2.xx kernels are
  coming from Red Hat to fix these holes for those releases? Or have
  earlier Red Hat kernels (and releases) just been abandoned? Or are
  they just not affected?)

-Barry K. Nathan <barryn@pobox.com>
