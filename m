Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbTI2DvJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 23:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTI2DvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 23:51:09 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:8405 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262795AbTI2DvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 23:51:07 -0400
Date: Sun, 28 Sep 2003 20:50:46 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2nd proc not seen
Message-ID: <20030928205045.B21288@google.com>
References: <20030904021113.A1810@google.com> <20030904091437.A25107@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030904091437.A25107@google.com>; from fcusack@fcusack.com on Thu, Sep 04, 2003 at 09:14:37AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 09:14:37AM -0700, Frank Cusack wrote:
> On Thu, Sep 04, 2003 at 02:11:13AM -0700, Frank Cusack wrote:
> > I think I've seen some recent talk about this problem.  I have an HPAQ
> > xw6000 w/ 2xP4 CPUs.  A RH kernel finds both CPUs (4 if I enable HT).  A
> > kernel.org kernel only finds 1 (2 if I enable HT).

This turned out to be a CPU numbering issue.  The HPAQ machine numbers
the cpus #0 and #6.  I had NR_CPUS set to 2.  That only works if the CPUs
are physically numbered 0 and 1.

So NR_CPUS is a little misleading.  I could suggest a Config.help change
if you like.

/fc
