Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbSLEESU>; Wed, 4 Dec 2002 23:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267210AbSLEEST>; Wed, 4 Dec 2002 23:18:19 -0500
Received: from holomorphy.com ([66.224.33.161]:20616 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267208AbSLEEST>;
	Wed, 4 Dec 2002 23:18:19 -0500
Date: Wed, 4 Dec 2002 20:25:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dead & Dying interfaces
Message-ID: <20021205042546.GD9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
References: <20021115184725.H20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115184725.H20070@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 06:47:25PM +0000, Matthew Wilcox wrote:
> We forgot to remove a lot of crap interfaces during 2.5 development.
> Let's start a list now so we don't forget during 2.7.
> This list is a combination of interfaces which have gone during 2.5 and
> interfaces that should go during 2.7.  Think of it as a `updating your
> driver/filesystem to sane code' guide.

do_each_thread()/for_each_process():
------------------------------------
(1) reserved for special "catastrophic" operations
	e.g. OOM, killall, cap_set_all(), etc.
(2) use for_each_task_pid() or maintain lists/tables of tasks etc. instead
(3) kernel API is missing some pieces to make it avoidable for all callers


Bill
