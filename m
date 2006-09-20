Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWITUME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWITUME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWITUMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:12:03 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:938 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750715AbWITUMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:12:01 -0400
Date: Wed, 20 Sep 2006 13:11:51 -0700
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: sekharan@us.ibm.com, clameter@sgi.com, npiggin@suse.de,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920131151.4a810be2.pj@sgi.com>
In-Reply-To: <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158777240.6536.89.camel@linuxchandra>
	<6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M. wrote:
> Rather than adding a new process container abstraction, wouldn't it
> make more sense to change cpuset to make it more extensible (more
> separation between resource controllers), possibly rename it to
> "containers",

Without commenting one way or the other on the overall advisability
of this (for lack of sufficient clues), if we did this and renamed
"cpusets" to "containers", we would still want to export the /dev/cpuset
interface to just the CPU/Memory controllers.  Perhaps the "container"
pseudo-filesystem could optionally be mounted with a "cpuset" option,
that just exposed the cpuset relevant interface, or some such thing.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
