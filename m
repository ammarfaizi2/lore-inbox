Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVEMVAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVEMVAm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVEMU5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:57:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:33425 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262543AbVEMU5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:57:14 -0400
In-Reply-To: <1115946620.6248.299.camel@localhost>
To: linuxram@us.ibm.com
Cc: 7eggert@gmx.de, ericvh@gmail.com, hch@infradead.org, jamie@shareable.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Miklos Szeredi <miklos@szeredi.hu>, smfrench@austin.rr.com
MIME-Version: 1.0
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFEFDF2D93.56922D33-ON88257000.0072463B-88257000.00730C46@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Fri, 13 May 2005 13:56:06 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_04122005|April 12, 2005) at
 05/13/2005 16:57:08,
	Serialize complete at 05/13/2005 16:57:08
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Sorry if I am saying something dumb here.
>Correct me.  When a file descriptor is sent from one process to other,

This confusion, incidentally, is brought to you by the ambiguous use of 
the term "file descriptor."  In classic Unix, the "file descriptor" is the 
integer that open() returns.  It's an improper use of the term 
"descriptor," as this value does not describe but identifies.  But in the 
SCM_RIGHTS context, the term "file descriptor" is used to refer to a 
handle for a file image.  While it's true that a file descriptor goes in 
one end of the pipe and a (generally different) file descriptor comes out 
the other end, what's being passed is a handle for a file image (aka open 
instance).

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems

