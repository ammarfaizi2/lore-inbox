Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbULUJhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbULUJhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 04:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbULUJhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 04:37:35 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:18672 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261461AbULUJhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 04:37:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dF9CqbLlt7pK6+X4kPclCE5I4D2Q/Xd9rg3vhnkId4OyodziEKIoZzdh0VHLRw4KiaCXObDB/vRKzrZlrB94Pp385gw8WKPZMpsC9UJOiqyfj9typQK896MlfZUHN4ZrFR81Ag8EX4IBhA61QA35UMO1Lcik7TQntV2hHrY4r34=
Message-ID: <81b0412b041221013752802fc5@mail.gmail.com>
Date: Tue, 21 Dec 2004 10:37:32 +0100
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: linux lover <linux.lover2004@gmail.com>
Subject: Re: loading modules at kernel startup
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <72c6e3790412210114650e05d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <72c6e3790412210114650e05d1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2004 14:44:23 +0530, linux lover
<linux.lover2004@gmail.com> wrote:
> Hi all,
> How to load own kernel modules just after eth0
> interface is brought up?
> I want to load kernel module as soon as networking part of kenrel
> starts.

Look at udev and hotplug

> I dont want to loose any packets that travels on my linux
> machine.

You'll always loose something: there will be a gap between activating
of the network interface and running of your module (or sniffer, as it sounds).
