Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTJIP1G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 11:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTJIP1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 11:27:06 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:63674 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262186AbTJIP1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 11:27:02 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16261.32253.607756.900278@gargle.gargle.HOWL>
Date: Thu, 9 Oct 2003 10:25:49 -0500
To: James Morris <jmorris@redhat.com>
Cc: Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
       <karim@opersys.com>, <bob@watson.ibm.com>
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
In-Reply-To: <Pine.LNX.4.44.0310090943200.13537-100000@thoron.boston.redhat.com>
References: <16259.10547.72758.205812@gargle.gargle.HOWL>
	<Pine.LNX.4.44.0310090943200.13537-100000@thoron.boston.redhat.com>
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris writes:
 > On Tue, 7 Oct 2003, Tom Zanussi wrote:
 > 
 > > This 4-part patch contains code for an interim version of relayfs (see
 > > Documentation below for a description of relayfs).
 > 
 > What is wrong with using Netlink sockets instead of this?

Nothing, if they meet your needs.  One thing you can do with relayfs
files is mmap() them.  That combined with the kernel-side API,
designed to make writing data into buffers and transferring it as
large blocks to user-space efficient and flexible, allows for
high-speed, high-volume applications which I'm not sure Netlink was
designed for.

relayfs can also be used in 'packet' mode, using read(2) to read data
as it becomes available, so it can be used for low-speed, low-volume
applications as well.  Also, some people might find the file-based
approach more natural to deal with.  Personal preference, I suppose.

Tom


 > 
 > 
 > - James
 > -- 
 > James Morris
 > <jmorris@redhat.com>
 > 
 > 
 > 

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

