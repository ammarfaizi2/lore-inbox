Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbTJDBJH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 21:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbTJDBJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 21:09:07 -0400
Received: from main.gmane.org ([80.91.224.249]:63937 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261689AbTJDBI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 21:08:58 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [BUG] Alpha (EV56), lseek64, and /dev/kmem
Date: Sat, 04 Oct 2003 03:08:55 +0200
Message-ID: <yw1x7k3lajx4.fsf@users.sourceforge.net>
References: <200310031942.50234.kelledin+LKML@skarpsey.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:YkdfabV3JzWYUBuCJJOEWsEULMU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kelledin <kelledin+LKML@skarpsey.dyndns.org> writes:

> I just found that on my Alpha box, lseek64() has a bit of 
> difficulty seeking through /dev/kmem to extremely high 
> values--specifically, any value >=0x8000000000000000 (the 64th 
> bit set).  Whenever it's supposed to seek to (and return) such a 
> value, lseek64() returns -1 instead and sets errno to a 
> seemingly random garbage value.  Userspace has no real choice 
> except to interpret this as an error.
>
> So far it's doing this on both xfs and ext2/3, so I'm betting 

/dev/kmem hasn't anything to do with filesystems, right?

> it's fs-independent.  I suppose it could be the kmem driver 
> itself deciding to be quirky?  I have no way of knowing if 
> lseek64() will stumble like this on a real file, as I'd probably 
> need more drive space than God to test that!

You could create a sparse file, but I don't think any filesystem
support that big files.

-- 
Måns Rullgård
mru@users.sf.net

