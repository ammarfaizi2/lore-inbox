Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWDWXrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWDWXrm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 19:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWDWXrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 19:47:42 -0400
Received: from pproxy.gmail.com ([64.233.166.177]:20190 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751180AbWDWXrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 19:47:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kTHGBcaWMWhrG4zcaPRU93hdsWqk5YdnHOcrbP8SMYDmnm+Zt9j0NrKGmketx+lVNLH1ocJFq6Uxz08e/CusI0H1XS8uAz2FO9Sw4W9OvdgWYHpX2oZW+VIbsVfgT4c/+LH8DgSCNEe2F6RgNvfWEt9wLEwE7pUsTPooYqRoKgg=
Message-ID: <444C1211.8090505@gmail.com>
Date: Mon, 24 Apr 2006 07:47:29 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Yum Rayan <yum.rayan@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] VBE DDC bios call stalls boot
References: <df35dfeb0604231208x416b7ab0ya612d918bb239140@mail.gmail.com> <20060423202428.GC14680@redhat.com>
In-Reply-To: <20060423202428.GC14680@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sun, Apr 23, 2006 at 12:08:27PM -0700, Yum Rayan wrote:
> 
>  > There is a bios call to check if read EDID is supported. My first
>  > thought was that before doing read EDID, video.S should first check to
>  > see if the hardware supports the read EDID feature. Unfortunately that
>  > bios call too ends up in the woods until I physically
>  > disconnect/reconnect my CPU video output that feeds into the KVM.
> 
> Is this how your patch looked when you tried this ?

I've discovered that checking for availability does not give any added benefit, 
but this is the correct approach and I have to agree with this patch.

Tony
