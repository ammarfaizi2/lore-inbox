Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWJ1U3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWJ1U3K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 16:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWJ1U3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 16:29:09 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:45462
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751390AbWJ1U3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 16:29:08 -0400
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with /proc/mounts and statvfs (implementing df).
Date: Sat, 28 Oct 2006 16:28:58 -0400
User-Agent: KMail/1.9.1
References: <200610281537.07145.rob@landley.net>
In-Reply-To: <200610281537.07145.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610281628.58174.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 October 2006 3:37 pm, Rob Landley wrote:
> Problem #2: statfs() and statvfs() are returning 0 in the f_fsid.

Which is apparently a known issue, the field has never worked and is useless, 
and what you're supposed to do is a normal stat() on the sucker and and use 
st_dev, which has been horribly abused to perform the function of uniquely 
identifying things like tmpfs instances and /proc. :)

A fix to problem #1 would still be nice, but I can work around most of it...

Thanks,

Rob
-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
