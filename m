Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWCXAoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWCXAoM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 19:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWCXAoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 19:44:12 -0500
Received: from pproxy.gmail.com ([64.233.166.176]:5491 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751500AbWCXAoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 19:44:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QMhh5le282LrSc05M7QQ8bb31beu5U6eRKQTW8OaHO/ehKD50BvbZuFS+J64L//r3M4MPg++Ue5NfU7dUg1z7E3Z/WIXJl6dQBFRqZz5Mx1ov0WDTSriIwRomX8mc40ubXiHQAQ3dlllIufNsiplO5W1R8GWSDF4XVyOVx4ZvXU=
Message-ID: <44234115.7010303@gmail.com>
Date: Fri, 24 Mar 2006 08:45:09 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector
References: <44216612.3060406@gmail.com> <1143101844.3147.9.camel@laptopd505.fenrus.org>
In-Reply-To: <1143101844.3147.9.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-03-22 at 22:58 +0800, Yi Yang wrote:
>   
>> This patch implements a new connector, Filesystem Event Connector,
>>  the user can monitor filesystem activities via it, currently, it
>>  can monitor access, attribute change, open, create, modify, delete,
>>  move and close of any file or directory.
>>     
>
>
> how is this not redundant functionality with the audit subsystem ?
>   
If you open Audit option, audit subsystem will audit all the syscalls, 
so it adds big overhead for the whole system,
but Filesystem Event Connector just concerns those operations related to 
the filesystem, so it has little overhead,
moreover, audit subsystem is a complicated function block, it not only 
sends audit results to netlink interface, but also
 send them to klog or syslog, so it will add big overhead.

I think you can look File Event Connector as subset of audit subsystem, 
but File Event Connector is a very lightweight
 subsystem.
>
>
>   

