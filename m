Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWDKUkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWDKUkh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWDKUkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:40:37 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:41645 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751384AbWDKUkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:40:36 -0400
Message-ID: <443C1738.20605@gentoo.org>
Date: Tue, 11 Apr 2006 21:53:12 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060401)
MIME-Version: 1.0
To: John Heffner <jheffner@psc.edu>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 regression: Very slow net transfer from some hosts
References: <443C03E6.7080202@gentoo.org> <443C024C.2070107@psc.edu> <443C0B74.50305@gentoo.org> <443C09A7.2040900@psc.edu>
In-Reply-To: <443C09A7.2040900@psc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Heffner wrote:
>> tcp_wmem: 4096    16384   131072
>> tcp_rmem: 4096    87380   174760
>> tcp_mem: 98304   131072  196608
> 
> These are (I assume) with the patch reversed.  What are the values with 
> the patch applied?

Yes- that was on a good kernel, with the patch reversed.

On a bad kernel, with the patch applied (2.6.16-git16):

tcp_wmem: 4096    16384   4194304
tcp_rmem: 4096    87380   4194304
tcp_mem: 98304   131072  196608

They seem to be identical, which makes sense, since most websites work 
just fine.

I am sending tcpdump's privately to you and Stephen. If anyone else 
wants to see them, just ask.

Daniel
