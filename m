Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbUJZOBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUJZOBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUJZOBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:01:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12728 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262272AbUJZOBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:01:05 -0400
Date: Tue, 26 Oct 2004 14:59:55 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Mathieu Segaud <matt@minas-morgul.org>, jfannin1@columbus.rr.com
Cc: Christophe Saout <christophe@saout.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1: LVM stopped working
Message-ID: <20041026135955.GA9937@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Mathieu Segaud <matt@minas-morgul.org>, jfannin1@columbus.rr.com,
	Christophe Saout <christophe@saout.de>,
	linux-kernel@vger.kernel.org
References: <87oeitdogw.fsf@barad-dur.crans.org> <1098731002.14877.3.camel@leto.cs.pocnet.net> <20041026123651.GA2987@zion.rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026123651.GA2987@zion.rivenstone.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 08:36:51AM -0400, jfannin1@columbus.rr.com wrote:
> LVM doesn't work with 2.6.9-mm1 here either, complaining that it
> can't find all the pv's. I'm not using any sort of encryption. Here,
> pvdisplay reports:

> I can open the device nodes for the 'missing' pv's in a hexeditor and see the
> uuid magic; if I reboot into 2.6.9-rc4-mm1 they are found without a
> problem, and everything works.

Firstly enable lvm debugging.  lvm.conf: log { file="/tmp/lvm2.log" level=7 }
Compare the lvm log files for the kernels to see where it's going wrong.
Then take complete straces (incl. read/write data) of the lvm process 
with each kernel and again compare them. [Or put files on web and send URLs.]

[To check for repeat of old problems with related symptoms:]
  Were both kernels compiled with the same compiler version? Which version?
  Does it make any difference if you rebuild lvm with --disable-o_direct?
 
Alasdair
-- 
agk@redhat.com
