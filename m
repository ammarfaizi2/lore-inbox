Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTJNBl2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 21:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTJNBl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 21:41:28 -0400
Received: from holomorphy.com ([66.224.33.161]:62344 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262131AbTJNBl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 21:41:27 -0400
Date: Mon, 13 Oct 2003 18:44:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Darren Williams <dsw@gelato.unsw.edu.au>
Cc: Linux Kern <linux-kernel@vger.kernel.org>
Subject: Re: VM code question
Message-ID: <20031014014427.GL16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Darren Williams <dsw@gelato.unsw.edu.au>,
	Linux Kern <linux-kernel@vger.kernel.org>
References: <20031014013227.GA20406@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014013227.GA20406@cse.unsw.EDU.AU>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 11:32:27AM +1000, Darren Williams wrote:
> I have a small question wrt some VM code.
> source file is include/linux/kernel.h
> #define container_of(ptr, type, member) ({                      \
>         const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
>         (type *)( (char *)__mptr - offsetof(type,member) );})
> what is the use of the 0 (zero) in the typeof? I am thinking
> that we are casting 0 to (type *) then referencing 'member' of
> 'type', however why do we require the 0 ?
> Just curious

It's an address calculation method. We subtract the address of the
start of the structure from the address of the member inside the
structure.


-- wli
