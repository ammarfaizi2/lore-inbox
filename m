Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbSLBBxW>; Sun, 1 Dec 2002 20:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbSLBBxW>; Sun, 1 Dec 2002 20:53:22 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:10258 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S263362AbSLBBxV>; Sun, 1 Dec 2002 20:53:21 -0500
Date: Mon, 2 Dec 2002 13:00:27 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Greg KH <greg@kroah.com>
cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       <linux-security-module@wirex.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] LSM fix for stupid "empty" functions
In-Reply-To: <20021201192532.GA9278@kroah.com>
Message-ID: <Mutt.LNX.4.44.0212021248290.20929-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Dec 2002, Greg KH wrote:

> > I think we still want to make sure that the module author has explicitly
> > accounted for all of the hooks, in case new hooks are added.
> 
> But with this patch, if the module author hasn't specified a hook, they
> get the "dummy" ones.  So the structure should always be full of
> pointers, making the VERIFY_STRUCT macro pointless.


Yes, but defaulting unspecified hooks to dummy operations could be
dangerous.  A module might appear to compile and run perfectly well, but 
be missing some important new hook.



- James
-- 
James Morris
<jmorris@intercode.com.au>


