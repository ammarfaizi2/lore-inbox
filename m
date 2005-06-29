Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVF2UCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVF2UCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVF2UCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:02:19 -0400
Received: from mxsf12.cluster1.charter.net ([209.225.28.212]:5861 "EHLO
	mxsf12.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262525AbVF2UCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:02:14 -0400
X-IronPort-AV: i="3.93,243,1115006400"; 
   d="scan'208"; a="1192742600:sNHT34720480"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17090.65093.315260.889211@smtp.charter.net>
Date: Wed, 29 Jun 2005 16:02:13 -0400
From: "John Stoffel" <john@stoffel.org>
To: linux-os@analogic.com
Cc: Sreeni <sreeni.pulichi@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: **** How to lock memory pages?
In-Reply-To: <Pine.LNX.4.61.0506291245170.22243@chaos.analogic.com>
References: <94e67edf05062810586d6141f3@mail.gmail.com>
	<m1br5p3ib8.fsf@ebiederm.dsl.xmission.com>
	<94e67edf050629083745bb4183@mail.gmail.com>
	<Pine.LNX.4.61.0506291245170.22243@chaos.analogic.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Richard" == Richard B Johnson <linux-os@analogic.com> writes:

Richard> On Wed, 29 Jun 2005, Sreeni wrote:

>> Is there a way to lock a particular portion of the memory pages during
>> kernel bootup? I want to re-use these pages when I load my
>> application. I *don't* wanna use the idea of reserving some physical
>> memory and using ioremap. I want something that kernel should be able
>> to manage this memory but I don't want any other application to use
>> this memory.

Richard> Wrong kind of kernel for this kind of use. The kernel
Richard> dynamically allocates/deallocates/pages of memory that it
Richard> knows about. The only way to do what you want, with a kernel
Richard> designed for multi-tasking multi-user applications use, is to
Richard> reserve memory during boot.

Sreeni, you might want to look at the mlockall() interface, but it's
also hard to know what's right to do here if you don't explain what
you are trying to do.  For example, why do you *care* which memory
address(es) your application gets?  

John
