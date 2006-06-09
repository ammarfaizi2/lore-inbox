Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWFITJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWFITJM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWFITJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:09:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:6181 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030287AbWFITJJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:09:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=QSQnXkj2s4bazGmwZJH8mO1/I04N9QMs6nPzH9SgrEO7SnlMU+lYHmRy7QHHFSdOvlRZq7Yyg0CvHNVlhqarZt6Uer0jPWJJGuinq8f5eFuPhtidHa+74G0WK3oCzkyH7sEzRLO8Xu0pHXA56rU37xVqJDeswWCUqexIfNzxedo=
Date: Fri, 9 Jun 2006 21:08:09 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: alex@clusterfs.com, torvalds@osdl.org, adilger@clusterfs.com,
       jeff@garzik.org, akpm@osdl.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-Id: <20060609210809.2e6953bd.diegocg@gmail.com>
In-Reply-To: <20060609205000.fce57f54.diegocg@gmail.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org>
	<448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<m33beecntr.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
	<20060609181020.GB5964@schatzie.adilger.int>
	<Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
	<m31wty9o77.fsf@bzzz.home.net>
	<20060609205000.fce57f54.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 9 Jun 2006 20:50:00 +0200,
Diego Calleja <diegocg@gmail.com> escribió:

> Not at all, a config option may be disabled by lots of distros
> and make backwards compatibility even more difficult than
> is already going to be.

(I meant: Distros could switch it off, and in a two years
timeframe for some reason you could try to read data from
a disk created by a kernel with that feature and it wont
work, meanwhile with the current approach you'll be able
to use a mount flag.)

In my very humble user opinion, the big difference between ext2/3
and ext3/4 is that ext2/3 really was supposed to be on-disk
compatible, except for the journal. However ext4, AIUI, is
supposed to be _really_ different.

The kernel that includes the 48bit patches will already be a sort
of "ext4" filesystem, since 2.6.17 and previous kernels are not
going to be able to read it. Moving the source to ext4 or keeping
it in ext3/ is just about mainteinance, not about making a new
filesystem or not - that will happen as soon as the patches are
merged.
