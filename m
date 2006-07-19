Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWGSKNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWGSKNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 06:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWGSKNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 06:13:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:37778 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964784AbWGSKNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 06:13:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oB7a4zbMoKx41kPyncGOnCMwvCf7O8NUcdZGriatPa0gQ0iv4WPtvDWqsHWtBc4jcf4hKJ+wkek1BQhgdipg1EsdNjzqAgYVr6CwS6VMaRTer+vGPDOZsddv7h+XFTL9ghvuFUzNNxVZRDBMg+0kpdT4lW1J/mqK1GoYBTs8f20=
Message-ID: <4df04b840607190313u75965101n9543ad3bd6716ace@mail.gmail.com>
Date: Wed, 19 Jul 2006 18:13:37 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: Improvement on memory subsystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <84144f020607190130q94b5563i436e16028eb9fb94@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
	 <84144f020607180925s62e6a7abvbaf66c672849170b@mail.gmail.com>
	 <4df04b840607182021hecef3b6v24c4794444a8e53c@mail.gmail.com>
	 <84144f020607190130q94b5563i436e16028eb9fb94@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which, like I said, is not enough to hold slab management structures
> (we need an array of bufctl_t in addition to struct slab).
>

Here, the off-slab is the same as the off-slab concept of Linux,
doesn't Linux stores bufctl_t array in its off-slab object?

I consider that we should try our best to explore the potential of
page structure. In my OS, page structure is just like a union and is
cast into different types according to its flag field.
