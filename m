Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268970AbRH0VNw>; Mon, 27 Aug 2001 17:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268997AbRH0VNo>; Mon, 27 Aug 2001 17:13:44 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:60425 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S268970AbRH0VNb>; Mon, 27 Aug 2001 17:13:31 -0400
Subject: Re: How to disable blanking of the screen in the kernel ?
From: Robert Love <rml@tech9.net>
To: Patrick Allaire <pallaire@gameloft.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <9A1957CB9FC45A4FA6F35961093ABB84041F9D2F@srvmail-mtl.ubisoft.qc.ca>
In-Reply-To: <9A1957CB9FC45A4FA6F35961093ABB84041F9D2F@srvmail-mtl.ubisoft.qc.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 27 Aug 2001 17:14:13 -0400
Message-Id: <998946860.11858.23.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-08-27 at 16:50, Patrick Allaire wrote:
> I am on a 2.2.19 kernel. I am doing an embedded box and I want to disable
> the console blanking ... how can I do that ? I dont have apm support in the
> kernel. there is no X on the box ...

the userspace solution is simply `setterm -blank 0'

if you dont want setterm, I wager it just uses an ioctl to set the
appropriate option.

if you want to disable it permanently, take a look around
drivers/char/console.c

there is a
static int blankinterval = 10*60*HZ;
setting that to 0 should do the job.  you could take it further and rip
out some of the *blank* functions that you wont be needing, to make your
kernel smaller.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

