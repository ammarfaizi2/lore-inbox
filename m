Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVHXQX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVHXQX7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVHXQX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:23:59 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:34504 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751112AbVHXQX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:23:58 -0400
Date: Thu, 25 Aug 2005 01:22:42 +0900 (JST)
Message-Id: <20050825.012242.74736989.taka@valinux.co.jp>
To: hyoshiok@miraclelinux.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20050824.231156.278740508.hyoshiok@miraclelinux.com>
References: <98df96d30508181629d85edb5@mail.gmail.com>
	<20050823.081246.846946371.hyoshiok@miraclelinux.com>
	<20050824.231156.278740508.hyoshiok@miraclelinux.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> The following patch does not use MMX regsiters so that we don't have
> to worry about save/restore the FPU/MMX states.
> 
> What do you think?

I think __copy_user_zeroing_intel_nocache() should be followed by sfence
or mfence instruction to flush the data.


