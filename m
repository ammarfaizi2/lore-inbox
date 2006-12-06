Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760275AbWLFHEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760275AbWLFHEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 02:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760278AbWLFHEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 02:04:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:52243 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760275AbWLFHEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 02:04:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NK6nIr7YnU0npJdayKv2uJaM2B9wzmRw5A59KgFsEsS9tfMCrbTe1bBg1SsVP/uVt782AQjMZ4pBSIlR0GleRVKD8CTMxi/l1LGf7mO6v76qwe1GBD6uim6I10TdkDCGqrHP9558wPvq+00NmIpxmWoqQ432NGv9yBXId4OZKjA=
Message-ID: <f383264b0612052304p52444392xf7ce9e22afed01ff@mail.gmail.com>
Date: Tue, 5 Dec 2006 23:04:32 -0800
From: "Matt Reimer" <mattjreimer@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] mm: D-cache aliasing issue in cow_user_page
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061205.165948.98864221.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f383264b0612042338y2609dd76w8ba562394800bbd0@mail.gmail.com>
	 <20061205.132412.116353924.davem@davemloft.net>
	 <f383264b0612051657r2b62c7acnf10b2800934ab8b3@mail.gmail.com>
	 <20061205.165948.98864221.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/06, David Miller <davem@davemloft.net> wrote:
> From: "Matt Reimer" <mattjreimer@gmail.com>
> Date: Tue, 5 Dec 2006 16:57:12 -0800
>
> > Right, but isn't he declaring that each architecture needs to take
> > care of this? So, say, on ARM we'd need to make kunmap() not a NOP and
> > call flush_dcache_page() ?
>
> No.  He is only solving a problem that occurs on HIGHMEM
> configurations on systems which can have D-cache aliasing
> issues.

Ok. Thanks for the clarification.

Matt
