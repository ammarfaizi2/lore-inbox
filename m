Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVCaTI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVCaTI7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 14:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVCaTI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 14:08:59 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:43425 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261631AbVCaTIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 14:08:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VbaIi6GnGdb0Dva/ZCyV2DXRB8fFORElzYp05jidOVv12L9/2abIS8goU2+aiRImGVCBjTIoWavIpXVpj0ydGnzxDhACdte00Q1E0nsRikpFq0A9DyelN0uozuH3aByNP6iGEOq12eLmOvJz2U+wRzjsTkcktcYB/z+mYAbthE4=
Message-ID: <d120d50005033111084a8a6f37@mail.gmail.com>
Date: Thu, 31 Mar 2005 14:08:36 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: klists and struct device semaphores
Cc: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0503311021040.7249-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.44L0.0503311054410.1510-100000@ida.rowland.org>
	 <Pine.LNX.4.50.0503310947180.7249-100000@monsoon.he.net>
	 <200503311018.02135.david-b@pacbell.net>
	 <Pine.LNX.4.50.0503311021040.7249-100000@monsoon.he.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005 10:26:36 -0800 (PST), Patrick Mochel
<mochel@digitalimplant.org> wrote:
> I don't understand what you mean. Even if a device is suspended, be it
> automatically after some amount of inactivity or as directed explicitly by
> a user, we want to be able to open the device and have it work.
> 
> Conversely, we only want to automatically suspend the device, or allow the
> device to be explicitly put to sleep, if the device is not being used.

Well, the disagreement in definition of "being used". Quite often you
have a device "open" for extended period of time (inactive ext2
partition is mounted on a disk) but device is not really active. You
could power it down and only wake up when there is a read or write
request.

It looks like "open" and "close" are terms better suited for class
devices while power management is applied to the "real" devices.

-- 
Dmitry
