Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbVI0Qkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVI0Qkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVI0Qkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:40:32 -0400
Received: from hera.kernel.org ([140.211.167.34]:34742 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965004AbVI0Qkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:40:31 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Sys fs
Date: Tue, 27 Sep 2005 09:40:37 -0700
Organization: OSDL
Message-ID: <20050927094037.3a4d54c4@dxpl.pdx.osdl.net>
References: <C75A388845B4B54B9CF5E2ADB589B0E30F389A86@btss005a.siemens-pse.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1127839218 765 10.8.0.74 (27 Sep 2005 16:40:18 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 27 Sep 2005 16:40:18 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.14 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005 14:22:47 +0200
Kormos Matej <Matej.Kormos@siemens.com> wrote:

> Hello,
> As far as I know all network drivers are automatically shown in
> /sys/class/net;
> But what to do if I want my kobject which is in my char driver appears in
> /sys/class/net?
> I am writing char driver which control some features on a switching device.
> My kobject appears in directly in /sys directory because I set kobject
> parent and kset to NULL.
> But I need to move it to the net directory. I have read the book Linux
> Device Drivers and searched web, but I have not found way how to acquire
> pointers to ksets created by another drivers and how to connect to net
> class. 
> 

If your driver is not a 'struct network_device' then don't put it
in /sys/class/net please. If you must then, it must export the same
files to keep from breaking assumptions of tools.
