Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275389AbRJBQRU>; Tue, 2 Oct 2001 12:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275529AbRJBQRC>; Tue, 2 Oct 2001 12:17:02 -0400
Received: from gap.cco.caltech.edu ([131.215.139.43]:7618 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S275389AbRJBQQ5>; Tue, 2 Oct 2001 12:16:57 -0400
Date: Tue, 2 Oct 2001 11:52:31 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Dinesh Gandhewar <dinesh_gandhewar@rediffmail.com>
Cc: mlist-linux-kernel@NNTP-SERVER.CALTECH.EDU
Subject: Re: your mail
Message-ID: <20011002115231.A26095@alcove.wittsend.com>
Mail-Followup-To: Dinesh Gandhewar <dinesh_gandhewar@rediffmail.com>,
	mlist-linux-kernel@nntp-server.caltech.edu
In-Reply-To: <20011002152945.15180.qmail@mailweb16.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011002152945.15180.qmail@mailweb16.rediffmail.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 03:29:45PM -0000, Dinesh  Gandhewar wrote:

> Hello,
> I have written a linux kernel module. The linux version is 2.2.14. 
> In this module I have declared an array of size 2048. If I use this
	array, the execution of this module function causes kernel to
	reboot. If I kmalloc() this array then execution of this module
	function doesnot cause any problem.
> Can you explain this behaviour?

	You didn't say how you declared the array or what the element
size was.  If the array elements were larger than a char, by saying an
array of size 2048, do you mean in bytes or in array elements?

	You also didn't say where you called your module from.  Was it
in an interrupt handler or at insmod time or from a system call.

	If it was a automatic array on the stack (declared inside the
function and not declared static), you probably overflowed the stack.

> Thnaks,
> Dinesh 

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

