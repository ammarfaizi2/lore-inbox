Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263187AbUKZTrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbUKZTrQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUKZTqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:46:46 -0500
Received: from zeus.kernel.org ([204.152.189.113]:65474 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262412AbUKZT1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:15 -0500
Subject: Re: pcnet32: 79c976 with fiber optic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Guido Guenther <agx@sigxcpu.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jonmason@us.ibm.com
In-Reply-To: <20041124171427.GA29693@bogon.ms20.nix>
References: <20041124171427.GA29693@bogon.ms20.nix>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101420214.18354.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 25 Nov 2004 22:03:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-24 at 17:14, Guido Guenther wrote:
> it works fine. Any idea what exactly causes the problem?

I've no idea whether the workaround is simply not supposed to be used on
fibre devices (I'm suprised the driver works on fibre full stop 8)). Its
certainly possible to do a cleaner change though even if nobody can work
out why.

Use lspci -v to find the subvendor/subdevice ID for the particular board
assembly and then skip the fixup for that device alone. That should let
you produce a diff that is safely mergable

