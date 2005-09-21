Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVIUQuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVIUQuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVIUQuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:50:24 -0400
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:15242 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751148AbVIUQuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:50:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=iL2Jj6QO4UR5sCBLzMDH8AbBpbfZQhXr4uCKieb2c5YCDPi46CQQkQjE/zIVLSsZS5G7Am+rohJNjpnftXWUsE7k1/oWt8uLXFLFBdYdyi1s1v7xS8fKiZQ7qbJRmdu9yjrXRx+nWpooqrdqiy7yHQZDz924GuJjwFrBRo4/D7A=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 04/12] HPPFS: fix access to ppos and file->f_pos
Date: Wed, 21 Sep 2005 18:48:59 +0200
User-Agent: KMail/1.8.2
Cc: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>,
       Jeff Dike <jdike@addtoit.com>,
       user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
References: <20050918140951.31461.78736.stgit@zion.home.lan> <20050921034649.GX7992@ftp.linux.org.uk>
In-Reply-To: <20050921034649.GX7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211848.59856.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 05:46, Al Viro wrote:
> On Sun, Sep 18, 2005 at 04:09:51PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> >  static ssize_t read_proc(struct file *file, char *buf, ssize_t count,
> >  			 loff_t *ppos, int is_user)
> >  {
> > @@ -228,17 +237,21 @@ static ssize_t read_proc(struct file *fi
> >  	if (read == NULL)
> >  		return -EINVAL;
> >
> > +	WARN_ON(is_user != (ppos != NULL));

> Eww....  Why not pass the right ppos in all cases?
Ok, can be done too. Was a bit in a hurry.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
