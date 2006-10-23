Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751976AbWJWQIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbWJWQIr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbWJWQIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:08:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:46778 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751976AbWJWQIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:08:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WXlU/nZZ1W+3AK6bTYmnuvQujoMOjshYSb47eS+LmOn+LjqRGyM4kx9ASyii8XsOP8QVsXfIYdAAKNVsGLQFEmtbL/xn7a3w7+26vVOIabpwLG2a86RfFtYak9Sf/nU156qNP4IXMtCMC4un5iPYHDUNap4MHX06vyVtig8ZqU8=
Message-ID: <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>
Date: Mon, 23 Oct 2006 18:08:44 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: Franck <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <453CE85B.2080702@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>
	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
	 <453CE85B.2080702@innova-card.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Miguel Ojeda wrote:
> > The driver is waiting in the -mm tree (-mm2 right now) for being
> > included in the mainline kernel sometime in the future. If it is
> > included, I will maintain it as I coded it as it apears in the
> > MAINTAINERS file. Why are you so worried about it if I can ask? Do you
> > want some more features or something like that?
>
> Are you sure the patch you sent to Andrew is your latest patch
> version ? For example I can't found any locks in the patch that
> you normally added during the V6 patch version; auxlcddisplay.c
> doesn't no exist...
>
>                 Franck
>

Yes, we are sure. AFAIK there is no need to lock when it is a fbdev.
The older version were "alone" drivers: they needed to lock because
they used fops and they exported functions.
