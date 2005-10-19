Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVJSLXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVJSLXu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVJSLXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:23:50 -0400
Received: from barad-dur.crans.org ([138.231.141.187]:37532 "EHLO
	barad-dur.minas-morgul.org") by vger.kernel.org with ESMTP
	id S1750766AbVJSLXt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:23:49 -0400
From: "Mathieu Segaud" <matt@regala.cx>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
Subject: Re: number of eth0 device
References: <20051019103135.GA9765@kestrel>
	<20051019104240.GC31526@harddisk-recovery.com>
X-PGP-KeyID: 0x2E13FCA8
X-PGP-Fingerprint: D41C FC4F 7374 D3FA A121 9182 90AC 62B0 2E13 FCA8
Date: mer, 19 oct 2005 13:23:48 +0200
In-Reply-To: <20051019104240.GC31526@harddisk-recovery.com> (Erik Mouw's
	message of "Wed, 19 Oct 2005 12:42:40 +0200")
Message-ID: <87psq1da2j.fsf@barad-dur.minas-morgul.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <erik@harddisk-recovery.com> disait dernièrement que :

> On Wed, Oct 19, 2005 at 12:31:35PM +0200, Karel Kulhavy wrote:
>> I am looking into Documentation/devices.txt in 2.4.25 and eth0 is not listed
>> there. If I grep "eth", I get only
>> 
>> 38 char        Myricom PCI Myrinet board
>> [...]
>> "This device is used for status query, board control and "user level
>> packet I/O."  This board is also accessible as a standard networking
>> "eth" device.  "
>> 
>> and then
>> 
>> /dev/pethr0
>> 
>> Is eth0 some kind of special device that doesn't have any number
>> assigned?
>
> Yes, there's no such thing as /dev/eth0, network interfaces have their
> own namespace. Linux uses the defacto standard BSD socket interface for
> networking, so blame the BSD people for violating the "everything is a
> file" rule.

well, the way NIC's behave kind of forbids this
taken from Linux Device Drivers, 3rd Edition, page 497
"The normal file operations (read, write, and so on) do not make sense
when applied to network interfaces, so it is not possible to apply the
Unix ''everything is a file'' approach to them"   

-- 
Mathieu
