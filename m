Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSGDEFv>; Thu, 4 Jul 2002 00:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317330AbSGDEFu>; Thu, 4 Jul 2002 00:05:50 -0400
Received: from rj.sgi.com ([192.82.208.96]:16319 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317329AbSGDEFt>;
	Thu, 4 Jul 2002 00:05:49 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal 
In-reply-to: Your message of "Wed, 03 Jul 2002 22:25:34 -0400."
             <3D23B21E.9030102@didntduck.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Jul 2002 14:08:13 +1000
Message-ID: <12364.1025755693@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jul 2002 22:25:34 -0400, 
Brian Gerst <bgerst@didntduck.org> wrote:
>Why not treat a module just like any other structure?  Obtain a 
>reference to it _before_ using it.

That is what try_inc_use_count() does.  But the interface is messy and
difficult to audit.  It relies on the caller taking some other lock
first to ensure that the module address will not change while you are
trying to call try_inc_use_count.

