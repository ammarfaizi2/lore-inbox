Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbVD2TJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbVD2TJy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbVD2TJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:09:14 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:36472 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262889AbVD2THM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:07:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jSFz9PEnQTC747DK2g0+1STRS7kSq9XAV8pP3Q1wL2fmPMyEIjrgpqq8W662K3108NJEiLM6ZuIlUaMYuKQfOoXfFNTxmiyS6g7EyAhZgcPcncR5cz7CeUN8tNEn4jRhjmfrg9Q2v+3ZyYyJ69V4CT9ZHiqqis1Z5c65JcoaaTU=
Message-ID: <5fc59ff30504291207424e6166@mail.gmail.com>
Date: Fri, 29 Apr 2005 12:07:12 -0700
From: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Reply-To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: msleep_interruptible() in ethtool ioctl and keyboard input
Cc: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <29495f1d050429114048da1847@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <468F3FDA28AA87429AD807992E22D07E05195E08@orsmsx408>
	 <29495f1d050429114048da1847@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> You really want this timer to go off immediately?
> 
Yes.

> Regardless....
> 
> >         msleep_interruptible(data * 1000);
> 
> Does the same issue occur if you revert this change and make it
> 
> set_current_state(TASK_INTERRUPTIBLE);
> schedule_timeout(data * HZ);
> 
> ?
No. The issue happens irrespective of whether it is
msleep_interruptible or the set_current_state/schedule_timeout combo.

ganesh.
