Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135833AbRDYHvC>; Wed, 25 Apr 2001 03:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135834AbRDYHuw>; Wed, 25 Apr 2001 03:50:52 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:8905 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135833AbRDYHue>; Wed, 25 Apr 2001 03:50:34 -0400
Date: Wed, 25 Apr 2001 09:50:32 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: mshiju@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with DHCP when using tokenring on 2.4.x
Message-ID: <20010425095032.A19553@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <CA256A38.0060F2DE.00@d73mta05.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <CA256A38.0060F2DE.00@d73mta05.au.ibm.com>; from mshiju@in.ibm.com on Tue, Apr 24, 2001 at 06:30:59PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 06:30:59PM +0530, mshiju@in.ibm.com wrote:
>            I have a problem with DHCP when using tokenring card on 2.4.x
> kernel . When I am using IBM tokenring adapter( all) and trying to hook on
> to the lan n/w using DHCP ,I get an error message "operation failed " from
> the dhcp client . The dhcp server is getting the broadcast message when the
> dhcp client  is run. I am using pump that comes with 6.2 redhat
> distribution .

Try at least stracing pump and find out _which_ operation fails.

Then find out where in the source there are messages "operation
failed" and whatever messages are around that message and compare
these positions with the call trace you get from strace and an
static analysis of the code paths leading to this message.

As a last resort try to run a debugger over pump (you have to
rebuild it without optimization and with debugging symbols).

This sounds like an user space problem until now, but once you
tried all this, we can decide whether it is a kernel bug or a bug
in pump, which got triggered by more correct behavior of the
lastest kernels.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
