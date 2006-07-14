Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422732AbWGNTvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422732AbWGNTvQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWGNTvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:51:15 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:60429 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1422732AbWGNTvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:51:15 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Michael Lindner <mikell@optonline.net>
Subject: Re: PROBLEM: close(fd) doesn't wake up read(fd) or select() in another thread
Date: Fri, 14 Jul 2006 20:51:43 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200607141146.52908.mikell@optonline.net> <200607141507.23501.mikell@optonline.net>
In-Reply-To: <200607141507.23501.mikell@optonline.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607142051.43428.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 July 2006 20:07, Michael Lindner wrote:
> Update: On advice from Nish Aravamudan I upgraded my kernel to 2.6.17.4 and
> verified that the problem still exists in that version.

This behaviour is POSIX compliant and should be expected. There is no bug.

If you want to work around it, use shutdown() as you suggested, and poll() 
instead of select() and wait for POLLNVAL or POLLHUP.

See the following Java "bug" which explains the situation a little better:

http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=4344135

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
