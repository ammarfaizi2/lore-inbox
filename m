Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262747AbRFCDc3>; Sat, 2 Jun 2001 23:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262750AbRFCDcS>; Sat, 2 Jun 2001 23:32:18 -0400
Received: from marine.sonic.net ([208.201.224.37]:5410 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S262747AbRFCDcF>;
	Sat, 2 Jun 2001 23:32:05 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Sat, 2 Jun 2001 20:31:27 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: select() - Linux vs. BSD
Message-ID: <20010602203125.A8378@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NDBBKBJHGFJMEMHPOPEGIEBCCIAA.jcwren@jcwren.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 02, 2001 at 10:47:49PM -0400, John Chris Wren wrote:
> I would have said just the opposite.  That if it you have a large number of
> handles you're waiting on, and you have to go back through and set the bits
> everytime you timeout that you would incur a larger overhead.  From the

Use a temp fd_set and assignment.

fd_set readset;

readset=set_to_watch

select(n, readset, NULL, NULL, timeout);

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
