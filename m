Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbUCIQEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbUCIQEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:04:23 -0500
Received: from outbound01.telus.net ([199.185.220.220]:47497 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S262017AbUCIQEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:04:16 -0500
Message-ID: <404DEAFD.8090802@bcgreen.com>
Date: Tue, 09 Mar 2004 08:04:13 -0800
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
CC: linux-admin@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Redirection of STDERR
References: <20040308111349.030feea6.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <20040308111349.030feea6.Christoph.Pleger@uni-dortmund.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Pleger wrote:
> Hello,
> 
> In my initialization scripts for hotplug (written for bash) the
> following command is used to redirect output which normally goes to
> stderr to the system logger:
> 
> "exec 2> >(logger -t $0[$$])"
I don't remember this syntax as legal.
what I'd use would be:
exec some_command 2>&1  | logger -t "$0[$$]"


On the other hand, this could replace the script you're
running with something that may never exit.. (sepending
on what the command does)

> 
> With kernel 2.4 this command works fine, but with kernel version 2.6.3
> it leads to a system hang.

-- 
Stephen Samuel +1(604)876-0426                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
    Powerful committed communication. Transformation touching
      the jewel within each person and bringing it to light.
