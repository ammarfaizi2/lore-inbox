Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUCQUE7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUCQUE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:04:58 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:49162 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262027AbUCQUE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:04:56 -0500
Date: Wed, 17 Mar 2004 21:05:04 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com,
       hunold@convergence.de
Subject: Re: [RFC][2.6] Additional i2c adapter flags for i2c client
 isolation
Message-Id: <20040317210504.34eb192f.khali@linux-fr.org>
In-Reply-To: <20040317174255.GE19060@kroah.com>
References: <4056C805.8090004@convergence.de>
	<20040316154454.GA13854@kroah.com>
	<20040316201426.1d01f1d3.khali@linux-fr.org>
	<20040316195325.GA22473@kroah.com>
	<1079515049.405817a9a3da0@imp.gcu.info>
	<20040317174255.GE19060@kroah.com>
Reply-To: sensors@stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > How would we export the value though? Numerical, with user-space
> > headers to be included by user-space applications? Or converted to
> > some explicit text strings so that no headers are needed?
> 
> A text string would be simple enough to use.

I'm not sure.  What about a chip driver that would belong to more than
one class?  What about the eeprom driver which will belong to all
classes?  With a numeric value, a simple binary operation handles all
the cases.  With text strings we would end having to parse a possibly
multi-valued string, and do string comparisons, with at least one
exception to handle.  This is likely to require much more resources,
don't you think?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
