Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUAARPI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 12:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264508AbUAARPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 12:15:07 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:27015
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S264502AbUAARPF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 12:15:05 -0500
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040101043333.186a3268.pj@sgi.com>
References: <20040101043333.186a3268.pj@sgi.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1072977297.1399.14.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Jan 2004 12:14:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 01/01/2004 klokka 07:33, skreiv Paul Jackson:
> This patch turns off all gcc warnings on comparing signed with unsigned
> numbers, by setting the gcc option -Wno-sign-compare in the top
> Makefile.
> 

Ignoring a potential bug is, of course one way of dealing with it. Most
of us would prefer to deal with the bug itself, though.... A lot of
effort has been put into coaxing gcc into detecting such comparison
errors (see, for instance, the somewhat "unconventional" Linux min() and
max() macros) precisely because signed comparisons have been a source of
kernel bugs in the past...

How about therefore instead sending him a patch which fixes the actual
code that is causing these warnings to be generated?

Cheers,
  Trond
