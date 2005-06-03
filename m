Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVFCKdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVFCKdx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 06:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVFCKdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 06:33:53 -0400
Received: from alog0169.analogic.com ([208.224.220.184]:30176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261211AbVFCKdv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 06:33:51 -0400
Date: Fri, 3 Jun 2005 06:32:43 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Tomko <tomko@avantwave.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: question why need open /dev/console in init() when starting
 kernel
In-Reply-To: <42A00065.9060201@avantwave.com>
Message-ID: <Pine.LNX.4.61.0506030629170.11487@chaos.analogic.com>
References: <42A00065.9060201@avantwave.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2005, Tomko wrote:

> Hi everyone,
>
> Do anyone know why it need to open("/dev/console"....) at the end of the
> init() before calling execve("/sbin/init") ? Why open this for the in ,
> out , err channel at this moment but not open it at the time when going
> to use , e.g. open it in the shell .
>
> Regards,
> TOM

For error messages (as well as it's the law)! Init needs a terminal.
Init is the 'father' of all future tasks and they need a default terminal
too.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
