Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264407AbRFSSZw>; Tue, 19 Jun 2001 14:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264652AbRFSSZd>; Tue, 19 Jun 2001 14:25:33 -0400
Received: from [209.191.64.160] ([209.191.64.160]:26889 "HELO linuxninja.org")
	by vger.kernel.org with SMTP id <S264407AbRFSSZb>;
	Tue, 19 Jun 2001 14:25:31 -0400
Date: Tue, 19 Jun 2001 11:25:11 -0700 (PDT)
From: Tim Pepper <tpepper@vato.org>
X-X-Sender: <tpepper@pepe.home.linuxninja.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: b_dev vs. b_rdev confusion
In-Reply-To: <20010619111136.A25405@cb.vato.org>
Message-ID: <Pine.LNX.4.33L2.0106191117570.25677-100000@pepe.home.linuxninja.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001 tpepper@vato.org wrote:

> All of the md code looks like it copies the buffer head, setting
> b_dev=b_rdev="real device" in the new bh and leaving b_dev==b_rdev="logical
> device" in the original bh.  I'm assuming they do this for a reason, but
> it would be nice from a performance standpoint to just touch b_rdev and
> b_end_io and be done.  Is there something I'm missing which necessitates the
> copy?

Oops...I take that back.  In the md code for raid1, raid5 and multipath
I see copies, but not in lvm or linear.


Tim

