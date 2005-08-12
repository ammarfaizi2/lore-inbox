Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVHLRa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVHLRa7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVHLRa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:30:59 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:1237 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750746AbVHLRa7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:30:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KUJCL20fbjnosWQa0MYH1iS8dINxYiIQ1d0Xp6mFqCVQWysOs/n+XLbVKq/e9Vq7HSSMFiMfqrif40ueq4T7kFdFI1O1w4yT3FTImubYrcV252JcXNZjaYejzB//3tFXd/tNWVgYaHORQCAoBnjGQDp17AkuWCBNyusUlsq8VBc=
Message-ID: <396556a20508121030de9b49d@mail.gmail.com>
Date: Fri, 12 Aug 2005 18:30:55 +0100
From: Adam Langley <alangley@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Edge triggered epoll with pts devices acts as level triggered
In-Reply-To: <396556a20508120419238abca6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <396556a20508120419238abca6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/05, Adam Langley <alangley@gmail.com> wrote:
> Waiting for edge triggered events (with EPOLLET) on pseudo terminal
> devices appears to act as if it were level triggered; when data is
> ready the fd is always returned by epoll_wait.

This occurs because writing to the terminal happens to cause a read
event to occur for pseudo terminals, but not for real terminals. This
is much less of a problem than the orginal message would suggest.


AGL

-- 
Adam Langley                                      agl@imperialviolet.org
http://www.imperialviolet.org                       (+44) (0)7906 332512
PGP: 9113   256A   CC0F   71A6   4C84   5087   CDA5   52DF   2CB6   3D60
