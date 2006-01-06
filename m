Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWAFWQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWAFWQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWAFWQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:16:54 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:63111 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932577AbWAFWQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:16:51 -0500
Date: Fri, 6 Jan 2006 14:16:17 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Patrick McHardy <kaber@trash.net>
cc: Marcel Holtmann <marcel@holtmann.org>, Michael Buesch <mbuesch@freenet.de>,
       jgarzik@pobox.com, bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Bcm43xx-dev] [Fwd: State of the Union: Wireless]
In-Reply-To: <43BE6697.3030009@trash.net>
Message-ID: <Pine.LNX.4.62.0601061414570.334@qynat.qvtvafvgr.pbz>
References: <1136541243.4037.18.camel@localhost>  <200601061200.59376.mbuesch@freenet.de>
  <1136547494.7429.72.camel@localhost>  <200601061245.55978.mbuesch@freenet.de>
 <1136549423.7429.88.camel@localhost> <43BE6697.3030009@trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Patrick McHardy wrote:

> Marcel Holtmann wrote:
>
>>> I just personally liked the idea of having a device node in /dev for
>>> every existing hardware wlan card. Like we have device nodes for
>>> other real hardware, too. It felt like a bit of a "unix way" to do
>>> this to me. I don't say this is the way to go.
>>> If a netlink socket is used (which is possible, for sure), we stay with
>>> the old way of having no device node in /dev for networking devices.
>>> That is ok. But that is really only an implementation detail (and for sure
>>> a matter of taste).
>> 
>> 
>> At the OLS last year, I think the consensus was to use netlink for all
>> configuration task. However this was mainly driven by Harald Welte and
>> he might be able to talk about the pros and cons of netlink versus a
>> character device.
>
> I think the main advantages of netlink over a character device is its
> flexible format, which is easily extendable, and multicast capability,
> which can be used to broadcast events and configuration changes. Its
> also good to have all the net stuff accessible in a uniform way.

character devices are far easier to script. this really sounds like the 
type of configuration stuff that sysfs was designed for. can we avoid yet 
another configuration tool that's required?

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

