Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293548AbSCGHni>; Thu, 7 Mar 2002 02:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310146AbSCGHn2>; Thu, 7 Mar 2002 02:43:28 -0500
Received: from adsl-209-233-33-110.dsl.snfc21.pacbell.net ([209.233.33.110]:35310
	"EHLO lorien.emufarm.org") by vger.kernel.org with ESMTP
	id <S293548AbSCGHnJ>; Thu, 7 Mar 2002 02:43:09 -0500
Date: Wed, 6 Mar 2002 23:43:08 -0800
From: Danek Duvall <duvall@emufarm.org>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: root-owned /proc/pid files for threaded apps?
Message-ID: <20020307074308.GA330@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20020307060110.GA303@lorien.emufarm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020307060110.GA303@lorien.emufarm.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 10:01:10PM -0800, Danek Duvall wrote:

> I just upgraded from 2.4.8-pre3-ac2 to 2.4.19-pre2-ac2, and found that
> for threaded programs like mozilla and xmms, files in /proc/<pid> are
> owned by root, even if the process belongs to another user.
> 
> I'll backtrack kernels to see if I can find the patch that caused it
> and report back if I hear nothing.

It's caused by the ac2 patch, but I'm not sure which part.  Maybe the
changes to set_user(), causing the dumpable flag to be set to zero, and
thus the uid/gid of the inode not to be set to the real owner?

Danek
