Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVHLWNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVHLWNe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 18:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVHLWNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 18:13:34 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:22249 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751301AbVHLWNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 18:13:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:cc:references:organization:content-type:mime-version:content-transfer-encoding:message-id:in-reply-to:user-agent:from;
        b=b0mScwynoObyUMDDaMLH+Mb65jQgNxGf/sRj2YWZ/vNowu5e6A724s7iPX7bsBhfWXLOpucl8Lgp8tp0IEGVv08ZL9gjzOFb+EHJ5+4j29pA4Bp1F/E8mJU+Bvuqpq5wlVRhAtWTQrXWthm5EKOLWdXvA5MYnU4divXLyrhlwfs=
Date: Sat, 13 Aug 2005 08:13:21 +1000
To: "Masoud Sharbiani" <masouds@masoud.ir>
Subject: Re: Via-Rhine NIC, Via SATA or reiserfs broken, how to tell??
Cc: "Vladimir V. Saveliev" <vs@namesys.com>, linux-kernel@vger.kernel.org
References: <54nnf1tv8722aq6med3mlr4mvg7nli0r09@4ax.com> <42FC7D5E.8020604@namesys.com> <mc2pf1tgih72uq4flc3hl6q0897r060ilp@4ax.com> <42FCB06A.5050609@masoud.ir>
Organization: http://www.squishybuglet.mine.nu/
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.sve1cjvzyuqkyt@magpie.mire.mine.nu>
In-Reply-To: <42FCB06A.5050609@masoud.ir>
User-Agent: Opera M2/8.02 (Win32, build 7680)
From: Grant Coady <grant.coady@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2005 00:21:30 +1000, Masoud Sharbiani <masouds@masoud.ir> wrote:

> Can you turn on UDP checksums and try again? That would isolate the
> fault between the network or SATA.

It is the second tarball extraction from cache that suffers data
corruption, not a network error.  I am in process of narrowing
down cause as I now have 2.4.32-pre3 and 2.6.13-rc6-git3 .configs
that work okay (5 tarball extracts, diff okay)on reiserfs and ext2.

Something to do with MTRR, highmem (box has 1GB), unwanted MP
detection in dmesg --> no longer network, filesystem and/or SATA
driver directly, dunno what yet, but tedious process of elimination
will take time.

How do I force fetching tarball from over NFS again?  At present
the repeat extractions are from memory, not from network.

Cheers,
Grant.
