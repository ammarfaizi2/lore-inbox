Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWBMXLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWBMXLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWBMXLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:11:14 -0500
Received: from smtp-5.smtp.ucla.edu ([169.232.47.138]:28315 "EHLO
	smtp-5.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1030261AbWBMXLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:11:13 -0500
Date: Mon, 13 Feb 2006 15:11:12 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Nathan Scott <nathans@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: any FS with tree-based quota system?
In-Reply-To: <20060214083353.A9257106@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0602131505080.330@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0602130959270.28894@potato.cts.ucla.edu>
 <20060214083353.A9257106@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006, Nathan Scott wrote:
> On Mon, Feb 13, 2006 at 11:03:35AM -0800, Chris Stromsoe wrote:
>> I'm looking for a file system with a tree-based quota system.  XFS on 
>> IRIX has projects, but that functionality didn't get ported over to 
>> Linux that I can see.
>
> You didn't look very closely then. ;)

This is from a Debian stable machine, with xfsprogs 2.6.20. :)  I'm more 
than happy to be proven wrong.

cbs:/usr/share/doc/xfsprogs > zcat README.quota.gz | tail -13

On IRIX, XFS supports project quota.  This is not (ever) likely to be
supported on Linux/XFS, as the concept of a project is specific to IRIX.
A filesystem that has used user quota on IRIX, however, can be migrated
to Linux, and vice-versa, as the ondisk format is shared between both
versions of XFS (and Linux/XFS is "endian clean").  Group quota support
has been implemented only in more recent versions of IRIX 6.5f, and the
same level of ondisk compatibility is now available as for user quota.

Have fun,

                 -- nathans@sgi.com




-Chris
