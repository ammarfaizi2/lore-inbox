Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWEKROk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWEKROk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 13:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWEKROk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 13:14:40 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:19990 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1030358AbWEKROj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 13:14:39 -0400
Subject: Re: [PATCH -mm] updated idetape gcc 4.1 warning fix
From: Daniel Walker <dwalker@mvista.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1147353102.26130.6.camel@localhost.localdomain>
References: <200605101810.k4AIAA8x006488@dwalker1.mvista.com>
	 <1147353102.26130.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 11 May 2006 10:14:37 -0700
Message-Id: <1147367677.26087.47.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-11 at 14:11 +0100, Alan Cox wrote:
> On Mer, 2006-05-10 at 11:10 -0700, Daniel Walker wrote:
> > I added returns for failures .. I would hope that this doesn't break anything in
> > userspace , but I'll confess that I have no way to determin that for certain . 
> > 
> > Hows that Alan?
> 
> You still need to walk the BHs I think. Also if an error occurs and some
> data is successfully transferred the standards explicitly require you
> return the amount of data successfully transferred if you report an
> error.


So it should try to write something even on an error ? It looks like it
would be really difficult to drop the data off the BHs without actually
doing the write .. The most straight forward way to handle the error
would be write all the data copied ..

Daniel



