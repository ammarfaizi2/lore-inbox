Return-Path: <linux-kernel-owner+w=401wt.eu-S964888AbWL1Dtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWL1Dtj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 22:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWL1Dtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 22:49:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:61517 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964888AbWL1Dti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 22:49:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AuIUpDEO+f1kbCEfsaw+egCVp8/+a2/xGDloSgbTumzrxlP87zNGoiL9q/4VJcFqBSqyaV+In2D85q4Alvjc408n2fhb0HdI4Okb4FqiNQCVSIoOoQIt8SgSQsIIyl5sfFG6R5G6vd9enPfeQygzXn7MPVwYRkWDcI0IY9Wtrv4=
Message-ID: <6d6a94c50612271949l66265cd4v4c63c1bdf3984417@mail.gmail.com>
Date: Thu, 28 Dec 2006 11:49:37 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Page alignment issue
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>
In-Reply-To: <6d6a94c50612270749j77cd53a9mba6280e4129d9d5a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50612270749j77cd53a9mba6280e4129d9d5a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/06, Aubrey <aubreylee@gmail.com> wrote:
> As for the buddy system, much of docs mention the physical address of
> the first page frame of a block should be a multiple of the group
> size. For example, the initial address of a 16-page-frame block should
> be 16-page aligned. I happened to encounted an issue that the physical
> addresss pf the block is not 4-page aligned(0x36c9000) while the order
> of the block is 2. I want to know what out of buddy algorithm depend
> on this feature? My problem seems to happen in
> schedule()->context_switch() call, but so far I didn't figure out the
> root cause.

It seems nothing depend on this feature. the problem you encounted is
the kernel task stack should be 2-page aligned.

-Aubrey
