Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWEYT02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWEYT02 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbWEYT02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:26:28 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:50829 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030370AbWEYT01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:26:27 -0400
Date: Thu, 25 May 2006 15:26:20 -0400
From: Michael Stone <mstone@mathom.us>
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
In-reply-to: <20060525084415.3a23e466.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org
Message-id: <20060525192618.GA27471@mathom.us>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-disposition: inline
X-Pgp-Fingerprint: 53 FF 38 00 E7 DD 0A 9C  84 52 84 C5 EE DF 7C 88
References: <348469535.17438@ustc.edu.cn>
 <20060525084415.3a23e466.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 08:44:15AM -0700, Andrew Morton wrote:
>These are nice-looking numbers, but one wonders.  If optimising readahead
>makes this much difference to postgresql performance then postgresql should
>be doing the readahead itself, rather than relying upon the kernel's
>ability to guess what the application will be doing in the future.  Because
>surely the database can do a better job of that than the kernel.

In this particular case Wu had asked about postgres numbers, so I 
reported some postgres numbers. You could probably get similar speedups 
out of postgres by implementing readahead in postgres. OTOH, the kernel 
patch also gives substantial speedups to thing like cp; the question 
comes down to whether it's better for every application to implement 
readahead or for the kernel to do it. (There are, of course, other 
concerns like maintainability or whether performance degrades in other 
cases, but I didn't test that. :)

Mike Stone
