Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWE3CTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWE3CTo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 22:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWE3CTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 22:19:44 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:27981 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751115AbWE3CTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 22:19:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=nzeSAmBYk7/k5P6wIqgOXaaNMKXz6xH+zBGd9TDqtB8kNygcLlTM4prqSDxA3dv39fsNLctGr1/VM350NHYcpfaeaT1woODfvDQxc4n9yfbCRtsw6mu5cqmD5+jtIWl6jjhbXYS6nVX62Fe950h/kbQgCgen3k/l6YwZPfzxkWw=
Message-ID: <447C2A48.1050200@gmail.com>
Date: Tue, 30 May 2006 20:19:36 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Nicolas Pitre <nico@cam.org>
CC: Jens Axboe <axboe@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       lkml <linux-kernel@vger.kernel.org>, mattjreimer@gmail.com
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
References: <11371658562541-git-send-email-htejun@gmail.com> <1137167419.3365.5.camel@mulgrave> <20060113182035.GC25849@flint.arm.linux.org.uk> <1137177324.3365.67.camel@mulgrave> <20060113190613.GD25849@flint.arm.linux.org.uk> <20060222082732.GA24320@htj.dyndns.org> <1141325189.3238.37.camel@mulgrave.il.steeleye.com> <20060302203039.GH28895@flint.arm.linux.org.uk> <20060302204432.GZ4329@suse.de> <Pine.LNX.4.64.0605291509370.11290@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0605291509370.11290@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre wrote:
> Has any discussion about this problem lead to some consensus?

Argghhh.. I completely forgot about this.

>> What do you think of the kmap_atomic_pio() (notoriously bad at names,
>> but it should get the point across) and kunmap_atomic_pio(), the latter
>> accepting a read/write flag to note if we wrote to a vm page?
>>
>> This is basically Tejuns original patch set, just moving it out of the
>> block layer so it's a generel exported property of the kmap api.
> 
> What was the problem with Tejun's patchset already to which RMK (and 
> many others) agreed?
> 
> I do have hardware that exhibits the problem and therefore I wish the 
> discussion could be resumed.

I'll follow up soon.  Sorry.

-- 
tejun
