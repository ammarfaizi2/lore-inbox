Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264556AbTK0PgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 10:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264557AbTK0PgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 10:36:06 -0500
Received: from [213.229.38.66] ([213.229.38.66]:61865 "HELO mail.falke.at")
	by vger.kernel.org with SMTP id S264556AbTK0PgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 10:36:04 -0500
Message-ID: <3FC61976.7090706@winischhofer.net>
Date: Thu, 27 Nov 2003 16:34:14 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Rene Engelhard <rene@rene-engelhard.de>
Subject: Re: 2.6.0-test11: MII broken?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rene,

this is a known bug in mii-tool, at least in Debian's version.

mii-tool uses old ioctl numbers which were kept in 2.4 (for 
compatibility issues?) but were removed in 2.6.

The solution is to get the source code, patch mii.h to the correct 
values for the SIG... "#define"s (which are found in 
/usr/src/linux/include somewhere, do a grep), and to recompile.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org




