Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbUAWCvv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 21:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265259AbUAWCvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 21:51:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:20186 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264971AbUAWCvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 21:51:51 -0500
Subject: Re: PATCH: Export console functions for use by Software
	Suspend	nice display
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040122203529.GB13377@nevyn.them.org>
References: <1074757083.1943.37.camel@laptop-linux>
	 <20040122082438.GV21151@parcelfarce.linux.theplanet.co.uk>
	 <1074796577.12771.81.camel@laptop-linux>
	 <20040122203529.GB13377@nevyn.them.org>
Content-Type: text/plain
Message-Id: <1074826188.976.185.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 13:49:48 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, by using write instead of blasting the low level code,
you will not have to worry about locking issues. (The way
you tap the low level stuff should require at least the console
semaphore held, write to /dev/console don't)

Ben

