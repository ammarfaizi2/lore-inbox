Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVDNKFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVDNKFJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 06:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVDNKFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 06:05:09 -0400
Received: from coderock.org ([193.77.147.115]:54919 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261466AbVDNKFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 06:05:02 -0400
Date: Thu, 14 Apr 2005 12:04:54 +0200
From: Domen Puncer <domen@coderock.org>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2: Compose key doesn't work
Message-ID: <20050414100454.GC3958@nd47.coderock.org>
References: <4258F74D.2010905@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4258F74D.2010905@keyaccess.nl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/05 11:52 +0200, Rene Herman wrote:
> Hi Vojtech.
> 
> I have mapped my right windows key to "Compose" in X:
...
> 
> This worked fine upto  2.6.11.7, but doesn't under 2.6.12-rc2. The key 
> doesn't seem to be doing anything anymore: "Compose-'-e" just gets me 
> "'e" and so on.

I can confirm this, right windows key works as scroll up, so it might
be related to recent scroll patches.

A quick workaround is to:
echo -n "0" > /sys/bus/serio/devices/serio1/scroll

serio1 being the keyboard here.

Btw. is that "-n" really necessary? Had too look at the code to figure
out why it's not working :-)

> 
> X is X.org 6.8.1, keyboard is regular PS/2 keyboard, directly connected.

Same here.


	Domen
