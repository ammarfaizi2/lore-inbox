Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVJGGlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVJGGlw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 02:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVJGGlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 02:41:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46466 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750777AbVJGGlv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 02:41:51 -0400
Date: Fri, 7 Oct 2005 07:41:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@vrfy.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [patch 08/28] Input: prepare to sysfs integration
Message-ID: <20051007064144.GA7992@ftp.linux.org.uk>
References: <20050915070131.813650000.dtor_core@ameritech.net> <d120d5000510061046y7d36de9cseccbbbd18529678@mail.gmail.com> <20051006230513.GB6981@midnight.suse.cz> <200510062258.07793.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510062258.07793.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 10:58:07PM -0500, Dmitry Torokhov wrote:
> Not necessarily, you just need to make sure that you don't try to access
> these fields when input_dev is "half-dead". But we have many issues with
> locking/lifetime rules in input core so that's just another item that
> needs to be considered.
> 
> I wanted to get basic sysfs support in and then work on locking...

... when the first one to fix should be the lifetime rules.  Both sysfs
stuff and locking depend on those...
