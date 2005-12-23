Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbVLWWZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbVLWWZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbVLWWZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:25:26 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:2457 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1161074AbVLWWZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:25:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ysz8yWLS5wddDz5rWV0+HUVkt7Rpd3MkN/zJRfzYIDvf11igZW8emWIkdUR3buiF5/y0LCmF/6athMQaEyE56ndA+8oM2fNmiMMDB4iOeagzQBRTLOmg1dzmyqa1BgJpWBX+97dACGJWzPJeBUnmUsvESIdUibpAXwYgoWf50r8=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.14.3 - sysfs duplicated dentry bug
Date: Fri, 23 Dec 2005 23:25:11 +0100
User-Agent: KMail/1.8.3
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200512091848.42297.blaisorblade@yahoo.it> <20051209175555.GA9761@kroah.com>
In-Reply-To: <20051209175555.GA9761@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512232325.12849.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 December 2005 18:55, Greg KH wrote:
> On Fri, Dec 09, 2005 at 06:48:41PM +0100, Blaisorblade wrote:
> > Q: Since when is a directory entry allowed to be duplicate?
> > A: Since Linux 2.6.14!
> >
> > $ uname -r
> > 2.6.14.3-bs2-mroute
> >
> > The only sysfs-related change is the use of a custom DSDT, which is new
> > to this kernel.

> Known bug, fixed in the 2.6.15-rc kernel tree.  It was a timer
> registering with the same name in two places :(

Sorry for answering so late (my latency in checking "spam" false positives is 
big) but shouldn't this have been backported to -stable? Also is this known 
to cause hangs at unmount time (I experience them at times and they're not 
network FSs-related) ?

> And yes, we should have more sysfs checks for stuff like this, any
> patches in this area would be greatly appreciated.
No idea about all kfoo stuff at the present moment^H^H^H year, sorry. Can't 
help.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
