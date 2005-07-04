Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVGDQTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVGDQTM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 12:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVGDQTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 12:19:11 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:39283 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261409AbVGDQOH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 12:14:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aY4sUiFM9bCyvt2MtD/Lrkg8vH6XL0sDEho78FErJRGa3U0Lj7UV+jFHgy8VZXdTb4+KflFykFC4ccdWz+jHBQd1YkvmKF1qphzoOqxDmrJEckaKRH91GpqN8tXFouQCJLFu/CHr3/97amcP4Gy/ZHR9tWQXaY4lxn9TJpX6S2I=
Message-ID: <2cd57c90050704091420198987@mail.gmail.com>
Date: Tue, 5 Jul 2005 00:14:05 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Paolo Galtieri <pgaltieri@mvista.com>
Subject: Re: patch to create sysfs char device nodes
Cc: linux-mtd@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1118327333.2401.42.camel@playin.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1118327333.2401.42.camel@playin.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/05, Paolo Galtieri <pgaltieri@mvista.com> wrote:
> Hi,
>   with DEVFS going away I discovered that no character device nodes are
> created if a flash device is present which contains filesystems. The
> mtd-utils package requires the existence of character device nodes for
> performing erase, lock and unlock functions.  The problem is that the
> flash device driver has not been modified to use sysfs instead of devfs.
> 
> I have attached a patch to mtdchar.c which uses the sysfs interface to
> create the appropriate nodes.  Please let me know if you have comments.

I encountered the same problem days ago. Thanks for the patch. A patch
based on yours will be sent in the next mail.

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
